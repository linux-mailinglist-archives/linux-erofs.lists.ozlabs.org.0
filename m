Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AF046FBF2
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:41:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NC743FRz3c73
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:41:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NC13k9qz3bmk
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:41:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-80.ma_1639121782; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-80.ma_1639121782) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:22 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 02/19] cachefiles: implement key scheme for demand-read mode
Date: Fri, 10 Dec 2021 15:36:02 +0800
Message-Id: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In demand-read mode, user daemon may prepare data blob files in advance
before they are lookud up.

Thus simplify the logic of placing backing files, in which backing files
are under "cache/<volume>/" directory directly.

Also skip coherency checking currently to ease the development and debug.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/namei.c | 8 +++++++-
 fs/cachefiles/xattr.c | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 61d412580353..981e6e80690b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -603,11 +603,17 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 bool cachefiles_look_up_object(struct cachefiles_object *object)
 {
 	struct cachefiles_volume *volume = object->volume;
-	struct dentry *dentry, *fan = volume->fanout[(u8)object->cookie->key_hash];
+	struct cachefiles_cache *cache = volume->cache;
+	struct dentry *dentry, *fan;
 	int ret;
 
 	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
 
+	if (cache->mode == CACHEFILES_MODE_CACHE)
+		fan = volume->fanout[(u8)object->cookie->key_hash];
+	else
+		fan = volume->dentry;
+
 	/* Look up path "cache/vol/fanout/file". */
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 0601c46a22ef..f562dd0d4bdd 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -88,6 +88,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
  */
 int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry = file->f_path.dentry;
 	unsigned int len = object->cookie->aux_len, tlen;
@@ -96,6 +97,10 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	ssize_t xlen;
 	int ret = -ESTALE;
 
+	/* TODO: coherency check */
+	if (cache->mode == CACHEFILES_MODE_DEMAND)
+		return 0;
+
 	tlen = sizeof(struct cachefiles_xattr) + len;
 	buf = kmalloc(tlen, GFP_KERNEL);
 	if (!buf)
-- 
2.27.0

