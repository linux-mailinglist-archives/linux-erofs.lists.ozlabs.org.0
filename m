Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7C968492
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 12:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725272648;
	bh=2e3EUUKKMGmRX7z2CVywk5vN1crgFDfQqlzF6oDKLWw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=QqXmc1+44tl3dt9R55ETWIUnnjPwzc3OKQb0vpXNJlmOobb7GJZy1egNISdWjjI1L
	 Rsv+S+8HwXwOcwGRNCFVmXKxXpn3w3U2rnhUY5Nc+QE5yC4LZxpzr3tCuQRcS7Y0vv
	 ZpAPppp9/ZDYwm+huYj16935yLGxLw13Y6FpmXC3vsLawLg5PdCzY90R5J+3o6xPTn
	 zXkB/jVJQNI7At+4y+mYxcoGVX9RqrCfEc++C+tvBSAiTVha1j/1umOmHeVGEZlzuY
	 cDPDXMcLKWchHgUCOdDQodJULYSSQWKmgDEaE2mFFV9Y0DwudAtKcFEOcI6W87Js79
	 CwkUCUGnYPN2Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy4c85Nb2z2yk8
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 20:24:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725272645;
	cv=none; b=me6pKQJN2XCVG5L2/jthVl6QYw1d9Ja2rFzDDfMyBO1bBPQZjNiasRcYvy+/hiugHCJw9qUgzn6K1QvCeANsgRLz6JAK6YC4hHRnMbEKcJPqyRm4TfUKC065kbI6fIen+oFQpnEGzsPluwW9nUF0DQn74PGeRbiVIMwDr3N8sGpO4wXLV93QvWlfb7tpKmx3NoIUzjGg0x3R/3Q5cP98NykvCuDM55KJY9bfZw3WDHLvFD9Ll+fRgPw4agqIDsObmbzqjTv9jal9yJhOZq+IW6LoYZJrGoYChNgj2YFKB4WeDmllZB0hEYnQrOVjjtwYS+EN299ZFls/0pUHzNRgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725272645; c=relaxed/relaxed;
	bh=2e3EUUKKMGmRX7z2CVywk5vN1crgFDfQqlzF6oDKLWw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QcV8RSHtS5xUI/lRCxhUYfr2buBybk3SSYOGgmd9pC62dT4opxe3H97Lcqcd5EjCWgSrDIfr4y6UXQRSGKZEOJgWJ+SNCZ9ocvCKtH9XjSrePTLbOVBw8orovM4oitIhdyTobpjOXo/siwSo8P2jySr5Ssg6W0v3BgeCOeHM1dd2xTzTgiEawh34U0QBic655qYONYZukMNNr3rIUfgB0KV8ACkDSSabQfTuCER39ytwFpXmbIoSVEffNAEyZh9LODBxVNps6xsZ+OsyUln3Meuz4EwVcebK+q0EjflbzpUYp+g27JoW3ikYjfUU6LQKAgPPQRoL4DCN3iZOG13ggw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=twziDvcR; dkim-atps=neutral; spf=pass (client-ip=203.205.221.205; helo=out203-205-221-205.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=twziDvcR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.205; helo=out203-205-221-205.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4Wy4c35pTvz2xtK
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 20:24:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725272637; bh=2e3EUUKKMGmRX7z2CVywk5vN1crgFDfQqlzF6oDKLWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=twziDvcRbN4B8h0WANYAHc/SAJtKkMaxphzsbSUiqbgUxpwhq9GWCleCrge2HIv/h
	 7SGDx+p9pq7O5g9KGkfLQqV54SztpTZCR0jdCgz/Xr3psW1hxBwn3B1yR9qJ59z0CB
	 f7a/9fgisp4aB6yDJvOvylBMIGIswzMH+g2sQNIE=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 5B60D264; Mon, 02 Sep 2024 18:22:54 +0800
X-QQ-mid: xmsmtpt1725272575toc07kzpz
Message-ID: <tencent_981814E6336F2724DD03EC54B0669E68D009@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQlXBlat3WTzOw9mUEXSgm0UD7ViM78QohWTFKYn8f69sUKcQMqV
	 N+xNxwWJMXovcnGgTbFukXBR/RSxUbVaIIMi3b4CJ9+NEkd4gLh7hm+Mb6kzWF3RotvdxHtoR7q/
	 eV9CDBQwDT2F6JYwP0CL4sTsUbrIGoLu8w70ztmuUAk+2DEBr0sAbejujbooTtEMYthZFQLi8Amu
	 eYaQtH3hLKSThkm2bNb1xtftuWxyQux2fu/I5mlt6a1LUDfS6fcOUX6tSk5dg7SDPRF86OtTNst3
	 6Mx+Sp/jRYjzguFK1fKmQgGWHbt+cGj76PfwoHOtknP1yy2FQIcXb1+ipFAU/ryHyCvpE2tjvMAJ
	 JLZrqS71syhmaH9YaAKHFaYxTc8zp4VDUcHFlA3dHUL02oZoofB+Ncl84lob0cKJHu5Ym3bv4OvG
	 w5gY5x+pzHezyNnmdxjGBLqmJIUjdUenNpuYdh2e/KXLWJGByrl6DAO7ecJjYYanMBeN8Nkcq9xw
	 kpHWjBmKGFSUaAMwqEutLjx4eiHFe1MQU6jNUO7q8FLn64xCZym5TusB6vjSgwQn3FKWXq2uJETD
	 c2/KmpGsJFBxjiYe3p3J41aMV0cbUW5eoIAqmpKFfHMwp51mzyi74aaiy1rkUuim5g7bhprXxKwn
	 wu1KqRwBzZgwsq4KxIKxUbXDG1mndqiVFk0fZqj6EU20IQJX/zAmzq3q49AbeIZe6VcgYTdg54qK
	 YPfMdX4Asok9BpwkSNiPrJsnVJgp2a8YHs/RA5MBv12W3kv9Y1xJUPCGMx2ayoJD0k21JzZ4DK4j
	 C+dTE/bqlkOVOaLikEDiQb+IuDpukCfCWe6x/p/FCgMi0wJHAzBnsB5oDrLTPKNfF/cOnEgPvtXT
	 ziN01V8UEI8qfQQqoC5nmcoxlCkzSkuO+yQvrP7FFE0cG4qDLQKY+TSszeaXnR+aSyxHKf5DBQv/
	 NtKGo3yZFromKnzRfksmt2E8EZaVkhE0sVxbcK1J9qtSjlLucE5g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: tests: implement checksum calculation for fssum
Date: Mon,  2 Sep 2024 18:22:51 +0800
X-OQ-MSGID: <20240902102252.2150182-2-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902102252.2150182-1-kyr1ewang@qq.com>
References: <20240902102252.2150182-1-kyr1ewang@qq.com>
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
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch specifically implements the function of calculating image checksum 
and provides interface function that enables fsck to call to complete the 
calculation of image checksum.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/fssum.c | 251 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/fsck/fssum.c b/fsck/fssum.c
index 7c5798c..c6bb1aa 100644
--- a/fsck/fssum.c
+++ b/fsck/fssum.c
@@ -255,3 +255,254 @@ int erofs_fssum_addinode(struct erofs_sum_t *dst, struct erofs_inode vi)
 	}
 	
 	return 0;
+}
+
+char* erofs_fssum_sum2string(struct erofs_sum_t *dst)
+{
+	int i;
+	char *s = erofs_fssum_alloc(CS_SIZE * 2 + 1);
+	
+	for (i = 0; i < CS_SIZE; ++i)
+		sprintf(s + i * 2, "%02x", dst->out[i]);
+		
+	return s;
+}
+
+int erofs_fssum_traverse_dirents(struct erofs_dir_context *ctx,
+			    void *dentry_blk, unsigned int lblk,
+			    unsigned int next_nameoff, unsigned int maxsize,
+			    struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	const char *errmsg;
+	int ret = 0;
+	bool silent = false;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+		unsigned int nameoff;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent check */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		ctx->de_nid = le64_to_cpu(de->nid);
+		erofs_dbg("traversed nid (%llu)", ctx->de_nid | 0ULL);
+
+		ret = -EFSCORRUPTED;
+		/* corrupted entry check */
+		if (nameoff != next_nameoff) {
+			errmsg = "bogus dirent nameoff";
+			break;
+		}
+
+		if (nameoff + de_namelen > maxsize || !de_namelen ||
+				de_namelen > EROFS_NAME_LEN) {
+			errmsg = "bogus dirent namelen";
+			break;
+		}
+
+		ctx->dname = de_name;
+		ctx->de_namelen = de_namelen;
+		ctx->de_ftype = de->file_type;
+		ctx->dot_dotdot = is_dot_dotdot_len(de_name, de_namelen);
+		ret = erofs_fssum_sum(ctx, dircs, level);
+		if (ret) {
+			silent = true;
+			break;
+		}
+		next_nameoff += de_namelen;
+		++de;
+	}
+out:
+	if (ret && !silent)
+		erofs_err("%s @ nid %llu, lblk %u, index %lu",
+			  errmsg, ctx->dir->nid | 0ULL, lblk,
+			  (de - (struct erofs_dirent *)dentry_blk) | 0UL);
+	return ret;
+}
+
+int erofs_fssum_iterate_dir(struct erofs_dir_context *ctx, struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_sb_info *sbi = dir->sbi;
+	int err = 0;
+	erofs_off_t pos;
+	char buf[EROFS_MAX_BLOCK_SIZE];
+
+	if (!S_ISDIR(dir->i_mode))
+		return -ENOTDIR;
+
+	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
+	pos = 0;
+	while (pos < dir->i_size) {
+		erofs_blk_t lblk = erofs_blknr(sbi, pos);
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					dir->i_size - pos, erofs_blksiz(sbi));
+		const struct erofs_dirent *de = (const void *)buf;
+		unsigned int nameoff;
+
+		err = erofs_pread(dir, buf, maxsize, pos);
+		if (err) {
+			erofs_err("I/O error occurred when reading dirents @ nid %llu, lblk %u: %d",
+				  dir->nid | 0ULL, lblk, err);
+			return err;
+		}
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= erofs_blksiz(sbi)) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
+				  nameoff, dir->nid | 0ULL, lblk);
+			return -EFSCORRUPTED;
+		}
+		err = erofs_fssum_traverse_dirents(ctx, buf, lblk, nameoff, maxsize, dircs, level);
+		if (err)
+			break;
+		pos += maxsize;
+	}
+	
+	return err;
+}
+
+int erofs_fssum_sum(struct erofs_dir_context *ctx, struct erofs_sum_t *dircs, int level)
+{
+	int err;
+	struct erofs_sum_t meta;
+	struct erofs_sum_t cs;
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
+	
+	
+	if (ctx->dot_dotdot)
+		return 0;
+	
+	err = erofs_read_inode_from_disk(&vi);
+	if (err) {
+		erofs_err("failed to read file inode from disk");
+		return err;
+	}
+
+	erofs_fssum_init(&meta);
+	erofs_fssum_init(&cs);
+	
+	erofs_fssum_addu64(&meta, level);
+	erofs_fssum_add(&meta, ctx->dname, ctx->de_namelen);
+	if (!S_ISDIR(vi.i_mode))
+		erofs_fssum_addu64(&meta, vi.i_nlink);
+	erofs_fssum_addu64(&meta, vi.i_uid);
+	erofs_fssum_addu64(&meta, vi.i_gid);
+	erofs_fssum_addu64(&meta, vi.i_mode);
+	erofs_fssum_addtime(&meta, vi.i_mtime);
+
+	if (S_ISDIR(vi.i_mode) || S_ISREG(vi.i_mode)) {
+		ssize_t kllen;
+		ssize_t ret;
+		char *keylst, *key;
+		
+		kllen = erofs_listxattr(&vi, NULL, 0);
+		if (kllen < 0)
+			return kllen;
+		
+		keylst = malloc(kllen);
+		if(!keylst)
+			return -ENOMEM;
+			
+		ret = erofs_listxattr(&vi, keylst, kllen);
+		if (ret < 0) {
+			free(keylst);
+			return err;
+		}
+		
+		for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+			char *value;
+			ssize_t size;
+			        
+			ret = erofs_getxattr(&vi, key, NULL, 0);
+			if (ret < 0)
+				return ret;
+			        
+			erofs_fssum_add(&meta, key, strlen(key));
+			if (ret == 0)
+				continue;
+			if (ret) {
+				size = ret;
+				value = malloc(size);
+			        if (!value)
+			        	return -ENOMEM;
+			        ret = erofs_getxattr(&vi, key, value, size);
+			        if (ret < 0){
+			        	free(value);
+			                free(keylst);
+			                return ret;
+			        }
+			        erofs_fssum_add(&meta, value, size);
+			        printf("key:%s val:%s\n", key, value);
+			}    
+		}
+		free(keylst);
+	}
+	
+	if (S_ISDIR(vi.i_mode)) {
+		struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+		};
+		
+		err = erofs_fssum_iterate_dir(&nctx, &cs, level + 1);
+		if (err)
+			return err;
+	} else {
+		if (S_ISREG(vi.i_mode)) {
+			erofs_fssum_addu64(&meta, vi.i_size);
+			err = erofs_fssum_addinode(&cs, vi); 
+			if (err)
+				return err;
+		} else if (S_ISLNK(vi.i_mode)) {
+			err = erofs_fssum_addinode(&cs, vi);
+			if (err)
+			        return err;
+		} else if (S_ISCHR(vi.i_mode) || S_ISBLK(vi.i_mode)) {
+			erofs_fssum_addu64(&cs, major(vi.u.i_rdev));
+			erofs_fssum_addu64(&cs, minor(vi.u.i_rdev));
+		}
+	}
+	
+	erofs_fssum_fini(&cs);
+	erofs_fssum_fini(&meta);
+	erofs_fssum_addsum(dircs, &cs);
+	erofs_fssum_addsum(dircs, &meta);
+	
+	return 0;
+}
+
+int erofs_fssum_calculate(struct erofs_dir_context *ctx)
+{
+	struct erofs_sum_t ans_cs;
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
+	struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+		};
+	int ret = 0;
+	
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret) {
+		erofs_err("failed to read file inode from disk");
+		return ret;
+	}
+	erofs_fssum_init(&ans_cs);
+	ret = erofs_fssum_iterate_dir(&nctx, &ans_cs, 1);
+	erofs_fssum_fini(&ans_cs);
+	fprintf(stdout, "%s\n", erofs_fssum_sum2string(&ans_cs));
+	
+	return ret;
+}
-- 
2.34.1

