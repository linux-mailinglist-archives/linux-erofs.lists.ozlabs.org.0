Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A96168FDF7
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:30:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC2ST3Dgzz3cf6
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:30:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=kM1azusV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=kM1azusV;
	dkim-atps=neutral
X-Greylist: delayed 531 seconds by postgrey-1.36 at boromir; Thu, 09 Feb 2023 14:30:20 AEDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC2SD74xtz3bVr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:30:20 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
	s=mail; t=1675912875;
	bh=GzTnOHgMbSFV51+peCeUABmUpKMMKHKkU+nhDrjkC3s=;
	h=From:Date:Subject:To:Cc:From;
	b=kM1azusVeo8YqS/mKVwRJyUm02Q35NZ+rnVV3JN2cb5sFe6DiL4ryRaVqK7+YP7dM
	 ohxQq7ZITmpe/jwqHistwI0g9lZfXWfeqvt8r4Smo8Z7SqdiP2c1N88oLnQPxNb7pp
	 4sOrcH3g4+bRA6U/qqJhqjgt0MDdF7KfBww38TP8=
Date: Thu, 09 Feb 2023 03:21:13 +0000
Subject: [PATCH] erofs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKhm5GMC/x2N0QrCMAwAf2Xk2UBW58P8FRFpa+qiox2JijL27
 wYf7+C4FYxV2ODYraD8FpNWHfpdB3mK9cYoV2cIFPYUaMRHS/fL87swsrZiSIXKkEfqaTiAVyk
 aY9JY8+Rdfc2zy0W5yOe/OZ237QcCtezRdgAAAA==
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675912873; l=1414;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GzTnOHgMbSFV51+peCeUABmUpKMMKHKkU+nhDrjkC3s=;
 b=Hu1XTvtiAXnaFLNKa2cFfVQtx11qktQnpeyv0vYantYPjDbxAigCn4m27SeZnx1WtJzmJSljQ
 plY3WVhODHrDUqcZCOn09JhUws1rdrAAZQ7XHMZ9CMuMl4LJeSAR9cP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/erofs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index fd476961f742..435e515c0792 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
 	.store	= erofs_attr_store,
 };
 
-static struct kobj_type erofs_sb_ktype = {
+static const struct kobj_type erofs_sb_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
 	.release	= erofs_sb_release,
 };
 
-static struct kobj_type erofs_ktype = {
+static const struct kobj_type erofs_ktype = {
 	.sysfs_ops	= &erofs_attr_ops,
 };
 
@@ -193,7 +193,7 @@ static struct kset erofs_root = {
 	.kobj	= {.ktype = &erofs_ktype},
 };
 
-static struct kobj_type erofs_feat_ktype = {
+static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
 };

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230209-kobj_type-erofs-0f0f4c901045

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

