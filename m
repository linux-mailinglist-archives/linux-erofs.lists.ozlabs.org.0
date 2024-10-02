Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45D98D503
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 15:26:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJbDx5JCbz2yVM
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 23:26:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727875599;
	cv=none; b=LGcxnL/fcpo8A3xqy2EWSHqzojNIhFFsBtombMSX8MbTO/x2DybOYJNpnsabbOrIbxwc/13ejZLuci7qBQcjQ9BpuYBfr1142L4dpOJYkXmZobaraFqEcvCdh/kn60U36+/8IDdo9HrVh+6IswsNTeIQMIyTcgQQnBCf3oNnBZd9VFB5DCId0OwXQMPrlYSwb1BirLTZi5NIlq44TKQKeh+xHKLrKVrkjl16xAE1xtxp2ZnlvSZxJMAfSV4WF8IWUKz2pFEhZApJZVxTOk9fLJFIi898k6qBNyAYdVa9xMLI6YSM6Sp9wjDLY6XQsslo++WYbQXT+aBBYEdtdhdDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727875599; c=relaxed/relaxed;
	bh=AM71QpWHeo2iO3DtAlei+JQfZAdDDTUsLK3oq6ONJhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKNjBm3QEU6vLo6jb1S5D6yFqFX7jd24cOrSpxyqaM0A7zahsRJH8Y4wPgmXy2Ox2ETTa5uWR/z1KwldMzj9WuD62MKtJRo80082sQmGqE2cDj4JsCTpFSUS7u6cjRqfxC6GONDe5IpKfbLbwt18uJesm9c8angJjMpBEmtWy94LFA8u5878UJLMJFNBzWuv9FgAra/RmllzRIT6/769rj8HmtE6MM2eVKloZtwu2I5tJFCre1uinWGtpb7ZYDUVkum2z5It4jZPHbC6IoHVHQhSzMOJNT5Q3oRGyr5zJ7/sT6bvtEvryb2TnQf6Axaq/defTwy3veCkZsYd2PfuZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BUPbBATH; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BUPbBATH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJbDt5c4Yz2xnX
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Oct 2024 23:26:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C2696A43CCC;
	Wed,  2 Oct 2024 13:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670F0C4CEC5;
	Wed,  2 Oct 2024 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875593;
	bh=N0daNTTHR4kVEaXoYIs2c6SecM2Ow+RiShhTwtKkVio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUPbBATHdN325EQDnrVhXhAyKzj77Hbc6mSazWL/LNwGbN340Rab465E9+sJyXhl4
	 l39j7GPVoXQXYI9kxZ21JJ56xT8F62zia6UR8JlHIB7XuOLGiuORZBV6Yr7qmpaI2Z
	 /KwB89WHVagvZhF79ViYINlo1PPQ4GaAK3T9i3rs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.11 123/695] cachefiles: Fix non-taking of sb_writers around set/removexattr
Date: Wed,  2 Oct 2024 14:52:01 +0200
Message-ID: <20241002125827.382185172@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: Sasha Levin <sashal@kernel.org>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 80887f31672970abae3aaa9cf62ac72a124e7c89 ]

Unlike other vfs_xxxx() calls, vfs_setxattr() and vfs_removexattr() don't
take the sb_writers lock, so the caller should do it for them.

Fix cachefiles to do this.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240814203850.2240469-3-dhowells@redhat.com/ # v2
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/xattr.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 4dd8a993c60a8..7c6f260a3be56 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -64,9 +64,15 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret == 0) {
+		ret = mnt_want_write_file(file);
+		if (ret == 0) {
+			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache, buf,
+					   sizeof(struct cachefiles_xattr) + len, 0);
+			mnt_drop_write_file(file);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
@@ -151,8 +157,14 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 	int ret;
 
 	ret = cachefiles_inject_remove_error();
-	if (ret == 0)
-		ret = vfs_removexattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache);
+	if (ret == 0) {
+		ret = mnt_want_write(cache->mnt);
+		if (ret == 0) {
+			ret = vfs_removexattr(&nop_mnt_idmap, dentry,
+					      cachefiles_xattr_cache);
+			mnt_drop_write(cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);
@@ -208,9 +220,15 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 	memcpy(buf->data, p, volume->vcookie->coherency_len);
 
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, len, 0);
+	if (ret == 0) {
+		ret = mnt_want_write(volume->cache->mnt);
+		if (ret == 0) {
+			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache,
+					   buf, len, 0);
+			mnt_drop_write(volume->cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
 					   cachefiles_trace_setxattr_error);
-- 
2.43.0



