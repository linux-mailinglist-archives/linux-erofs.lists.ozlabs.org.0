Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5580EB28
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 13:01:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SqHJt4sYLz3bq4
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 23:01:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 340 seconds by postgrey-1.37 at boromir; Tue, 12 Dec 2023 23:01:29 AEDT
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SqHJn1HwLz3bpp
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 23:01:27 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 6AAED1009A7CF
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 19:55:44 +0800 (CST)
Received: from lee-WorkStation.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 2504A380C85;
	Tue, 12 Dec 2023 19:55:07 +0800 (CST)
From: Li Yiyan <lyy0627@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fuse: support FUSE 2/3 multi-thread
Date: Tue, 12 Dec 2023 19:54:27 +0800
Message-Id: <20231212115427.2779792-1-lyy0627@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Support multi-threading for erofsfuse and adjust the configure.ac
to allow users of FUSE 3(> 3.2) to use API version 32, while maintaining
compatibility with API version 30 for FUSE 3 (3.0/3.1) and API version
26 for FUSE 2.

Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
---
 configure.ac |  8 +++++++-
 fuse/main.c  | 21 +++++++++++++++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9294e0c..bf6e99f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -343,7 +343,13 @@ AS_IF([test "x$enable_fuse" != "xno"], [
   saved_LIBS="$LIBS"
   saved_CPPFLAGS=${CPPFLAGS}
   PKG_CHECK_MODULES([libfuse3], [fuse3 >= 3.0], [
-    AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
+    PKG_CHECK_MODULES([libfuse3_0], [fuse3 >= 3.0 fuse3 < 3.2], [
+      AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
+    ], [
+      PKG_CHECK_MODULES([libfuse3_2], [fuse3 >= 3.2], [
+        AC_DEFINE([FUSE_USE_VERSION], [32], [used FUSE API version])
+      ])
+    ])
     CPPFLAGS="${libfuse3_CFLAGS} ${CPPFLAGS}"
     LIBS="${libfuse3_LIBS} $LIBS"
     AC_CHECK_LIB(fuse3, fuse_session_new, [], [
diff --git a/fuse/main.c b/fuse/main.c
index f07165c..32f59a3 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -699,7 +699,21 @@ int main(int argc, char *argv[])
 		EROFSFUSE_MOUNT_MSG
 		if (fuse_daemonize(opts.foreground) >= 0) {
 			if (fuse_set_signal_handlers(se) >= 0) {
-				ret = fuse_session_loop(se);
+				if (opts.singlethread) {
+					ret = fuse_session_loop(se);
+				} else {
+#if FUSE_USE_VERSION == 30
+					ret = fuse_session_loop_mt(se, opts.clone_fd);
+#elif FUSE_USE_VERSION == 32
+					struct fuse_loop_config config = {
+						.clone_fd = opts.clone_fd,
+						.max_idle_threads = opts.max_idle_threads
+					};
+					ret = fuse_session_loop_mt(se, &config);
+#else
+#error "FUSE_USE_VERSION not supported"
+#endif
+				}
 				fuse_remove_signal_handlers(se);
 			}
 			fuse_session_unmount(se);
@@ -717,7 +731,10 @@ int main(int argc, char *argv[])
 		if (fuse_daemonize(opts.foreground) != -1) {
 			if (fuse_set_signal_handlers(se) != -1) {
 				fuse_session_add_chan(se, ch);
-				ret = fuse_session_loop(se);
+				if (opts.mt)
+					ret = fuse_session_loop_mt(se);
+				else
+					ret = fuse_session_loop(se);
 				fuse_remove_signal_handlers(se);
 				fuse_session_remove_chan(ch);
 			}
-- 
2.34.1

