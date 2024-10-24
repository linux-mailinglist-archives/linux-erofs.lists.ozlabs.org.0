Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA819AF32D
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 22:00:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZGx401hJz3bgV
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 07:00:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729800021;
	cv=none; b=akUrapghMTop+JymMUpQo249g7Fy4CN9kexFPNX9OncjXJH61w2eqE6dBALKgq51mnqErnfjmBaa6djmYNyeDqkaI6IrU9dV3+gLDW0k6fwnKxSy7j6xqXOKT6/nqrFfTLVedUGIatrzTWYs7c7RfiV9V3nfr3tIB6QWbgqrtwN7dKTJ2b3oWVcTAQQVFfp48SfF2q6LOjQ1uSB6gawwRvyJ02YWerTHHcfOg8XDzPKLaxHt5LEo4Tree6wJgX/qPzcDemcEn/UDFMdiz1hSnjJHV04zbp51G9bmwkNrGbmE4262/VYYLJpaQSRWnGVhVku//FiRPFcfq2SQoZLBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729800021; c=relaxed/relaxed;
	bh=B4TZpsAzpo2pp8mtaK0ShzO+ppOPWu2dSnDYpyu3h3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFOl/4qTu5V5N6PAWUC2Rg8O7LN6pyTkb2gwsKfIxHFT/9Z+X135RlInzJsemdpiXiMQB4lTew4GVuZlTGMMsnIVwr4AHvf1Xn16jojNBI4wcqPb0d2QnUSvRcUiPxVZTI+N3ImrnCncvW9lUvN9D942PnjRVuOhhq+LNCjsTwMvXNYXKOBrc+4JHzFReI8dpTeqOqS59TobeNPgHH94x7KPT/GwChEW32pVaZSaXd0DnsMP40w6bWnrq9jEo3ZhPzVQ5/RwTP79VEOa+LduuZpHYR7IuS5Z+e53YCV45FR8UvkwMpQXH6OJephGLf1KnYhVfPegZz3hbcveeAykyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mbaynton.com; dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=aKA8slq9; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org) smtp.mailfrom=mbaynton.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mbaynton.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=aKA8slq9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZGwy6mbFz2xy7
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 07:00:17 +1100 (AEDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so22144356d6.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 24 Oct 2024 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1729800013; x=1730404813; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4TZpsAzpo2pp8mtaK0ShzO+ppOPWu2dSnDYpyu3h3o=;
        b=aKA8slq9QPf9ElVPInOxsn7gU02yLCKZEKACBUUY3FBB4LFjqpkMaN8YWEdG0MYb5L
         ogg66tyXhF5ftlCrwMR/wnNMnb2RwFr7443+zm4C2XFi/MPznWnlUMGoP8Pc83mjzKO9
         DVq0YuVBGGRbmq/5XJ+v+ZxDwNa8JHSZXlRWIEsZmSMSfkPKwJ093DJaj5G4q5pMVYkS
         NizAHONGS71brZw/gRncNcDRRYq4qbTinTjmcPYXqwAKIwq7P7gYejX0LAUB4pXyvocx
         frkg+fz+PMUIR5jC3mcEIbmr9m/5R16il9kgeGtBdshH2oPn82DteZoUyhzEbjeUYYrL
         +u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800013; x=1730404813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4TZpsAzpo2pp8mtaK0ShzO+ppOPWu2dSnDYpyu3h3o=;
        b=vBREDlgKM+RHZTgv6S7taYGtQHkmUoJQSfg2SrBrzlDw9G62F5q3+qrHlgcxFs0SuO
         FJ39SBlQX687XcRc+k5Gg3rbeZguj2glvVrpOLmuUKCwGZUX6wc/2426AQzjwrrkPi7h
         MK6p4sSsAi54YbapK7BpFBUtMZGS8kdEMxIqI+VuuYHtRR6j7tPHiEoUKx62UJGfeIe9
         bI4WAI34dtR4TrXc3gmfEJlfQ7nvD2z2JmB9LOXBSAi6Er7f8Z/NcJ+lJGvc6DdRdhA5
         NK7RlUoIbFHGWYPpSjsUqaRjxAf9Fyl4C90HtRTBnJUftovDX/IZSyiCv/qctCkNc7aB
         q+UA==
X-Forwarded-Encrypted: i=1; AJvYcCVB10gGh4l/jj0LtR4GMYdVw5zDZB4fnezA5+U+eRM8x5bRpt+MA67HNi2SUbo+59OkQSFUogK0qpARNA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGk2/SmwTSZhTpKZv8SJGZSSG/kWwNIVs5sCSnazsAG9zhHUcG
	xaI7iBFtuo58jYhXCh/5vOq8GKzwMdEM8fcVTEhUfdC1o4q77YHLYAG+ggLW07Q=
X-Google-Smtp-Source: AGHT+IEki9ubYQarrYdlWz/+aFzC3Jo/zw8lXMaVwZy3y7nhvkp1DHU/HwArJnOjoFwKIb7tPwqeCA==
X-Received: by 2002:a05:6214:5909:b0:6ce:3512:6224 with SMTP id 6a1803df08f44-6d08e7376d5mr45681306d6.21.1729800012596;
        Thu, 24 Oct 2024 13:00:12 -0700 (PDT)
Received: from mike-laptop.. ([50.203.248.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091ab0dsm53489526d6.72.2024.10.24.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:00:11 -0700 (PDT)
From: Mike Baynton <mike@mbaynton.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] mkfs: Fix input offset counting in headerball mode
Date: Thu, 24 Oct 2024 14:58:02 -0500
Message-Id: <20241024195801.1546336-1-mike@mbaynton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: sam@posit.co
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using --tar=headerball, most files included in the headerball are
not included in the EROFS image. mkfs.erofs typically exits prematurely,
having processed non-USTAR blocks as USTAR and believing they are
end-of-archive markers. (Other failure modes are probably also possible
if the input stream doesn't look like end-of-archive markers at the
locations that are being read.)

This is because we lost correct count of bytes that are read from the
input stream when in headerball (or ddtaridx) modes. We were assuming that
in these modes no data would be read following the ustar block, but in
case of things like PAX headers, lots more data may be read without
incrementing tar->offset.

This corrects by always incrementing the offset counter, and then
decrementing it again in the one case where headerballs differ -
regular file data blocks are not present.

Signed-off-by: Mike Baynton <mike@mbaynton.com>
---

I suspect headerball mode may be unfamiliar, since it exists due to my
prior contribution and my site is probably the only active user. As a recap,
the idea of a "headerball" is to offer a relatively easy to produce,
optimally efficient input format for constructing EROFS filesystems of only 
inode metadata. A headerball is a PAX tarball, except that all 512-byte
blocks containing regular file data are not present.

For convenience, a small example "headerball" can be downloaded from
https://gist.github.com/mbaynton/bae60bf1044d83985956c6dc5b199cc3

This produces a 67-inode EROFS image with this patch, and as I recall
about 3 inodes without it.

This also changes the behavior of ddtaridx format, which sounds like a
similar use case but the user is Alibaba. It _looks_ like this format
would also be affected, but without sample input I can't confirm.

 lib/tar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index b32abd4..726e565 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -808,8 +808,7 @@ out_eot:
 	}
 
 	dataoff = tar->offset;
-	if (!(tar->headeronly_mode || tar->ddtaridx_mode))
-		tar->offset += st.st_size;
+	tar->offset += st.st_size;
 	switch(th->typeflag) {
 	case '0':
 	case '7':
@@ -1022,8 +1021,10 @@ new_inode:
 			memcpy(inode->i_link, eh.link, inode->i_size + 1);
 		} else if (inode->i_size) {
 			if (tar->headeronly_mode) {
+				tar->offset -= st.st_size; // assumed wrong earlier
 				ret = erofs_write_zero_inode(inode);
 			} else if (tar->ddtaridx_mode) {
+				tar->offset -= st.st_size; // assumed wrong earlier
 				dataoff = le64_to_cpu(*(__le64 *)(th->devmajor));
 				if (tar->rvsp_mode) {
 					inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
-- 
2.34.1

