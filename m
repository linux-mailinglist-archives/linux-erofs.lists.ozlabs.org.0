Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1C967474
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 05:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725161631;
	bh=ZBPzh5phJWq9h1OnInVZKhpZVXGfbaPV2vCc4pS/DOE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=IlWBFN9FuyLnUes24d35LRU0Zh2POhpE/8wTfDClbRbqk31BImi2Pgu+iaCOnqpLT
	 UsFOOPj2LIgA/5moj11ydM+4S5MIxdYKrug4v9QQ+upGQAnQ2oKizqNwClL9l/zWAs
	 JZ9fg49anGZn1h23+M23qE3cmnFiswB9Eup+urqJ6JfNR/YOBlf31GOFLigUwwIT3j
	 Rmq70gbSCFRqQWmAXLRFivOYcjHflIYJbHSWQ0SiJcDxbz1zdm4DH29AVTvgUsoN7J
	 NsvwT3qnPtUWvod+vJ1N82rXokdVbyE0gzp6CIgrAstH59LQ0q2kSHWcNrnkb16GCG
	 MJ2kcFmq5vbcA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxHYC3ztKz2yjV
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 13:33:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.163.128.48
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725161629;
	cv=none; b=f9AktKj1G0cBlqqGWck1/8ImEFNMH/LlZjOXpCY0X7zXvOKeNXp1TXpahXDvzfTdzdbdjHaFsitgatVNpPg5l9hNIMFCF4GZ/MsEj1WvDHXnmTfdQGBhDHwckiOjVAIF795GUpxFfGcOg+DRi2wmNgMldAlyi3YapOF9c/1bGnfjw53cso4R4+CN2VUvHdsgVpRTNjwOJbq8mJ8klFS1PxTg8jHXuUDAjX4EbRm2eQv/i9sA4YzKE/SJmtKOtXW2yFm+AYCEJNdWTccExvGrbcVrPTngSLcSPJvCnKZyUXWuTKtaNXyNuSJNvazq4FoP60wm4i/XdCU5Nmje2QEa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725161629; c=relaxed/relaxed;
	bh=ZBPzh5phJWq9h1OnInVZKhpZVXGfbaPV2vCc4pS/DOE=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=nhBjMBpFZblc4qItRK4K6cwQPEOJTbSC+uJz26tAxlpNRNgY3dYq5hMgr2fCoEgGYB2CGlPD5tyusuT4xXdQuxeSZU+uHUiJ+46nZhokI+8Q1DyTH31ymV5KP+GvoALM96LjB+jZCEPbQBwq+6h5ROAEPawySe92+INAhUQhrrXvnFp8961dJr+WNNAi5jER0MCF6Ta/0I1OLL56pezG5Fjh9f4MZNT4kmj9RU2CJvk3DJoqSP2uzeqlf4oSD+WZzHPHhF0tQdW7hBynXQQ/wsbb9gpij6rwgtv/bQxLzShbG2MxSrKnnDtxbaU7tSZbeFSsYJhzIpBAiRaVtYYnjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OykHCSX5; dkim-atps=neutral; spf=pass (client-ip=43.163.128.48; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OykHCSX5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=43.163.128.48; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxHY75wX1z2y2B
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 13:33:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725161625; bh=ZBPzh5phJWq9h1OnInVZKhpZVXGfbaPV2vCc4pS/DOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OykHCSX52seFeuLVKVI0CXoel6ioaIWbrKwSklHuuaxJ9XTFJ1ZnFq5MRRf72a9pS
	 3dWy3dcRRDafsWzxTiiV+6WvCX5z7EXE1JKRZkwAMSZKX4eLIK8y/7PSEITEIssial
	 rziFz+nHq+svQLpnyu95RWIzRp9cE+7SZvzRYPrg=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 79AB0611; Sun, 01 Sep 2024 11:30:26 +0800
X-QQ-mid: xmsmtpt1725161433tkojcepcg
Message-ID: <tencent_132267E668941832E6876F8925D303EE5409@qq.com>
X-QQ-XMAILINFO: MYoXRtRaYRgxZJcmF5OyuXSrrtG/z+ABwiI9giDSVjq8bRgSJE0PsWxiBPMNCg
	 eeisHdnf0tZTUOWBkSQa74HVVCepGbIt0H7286rhHiSKo7ITk9jy+rvmB/haqVlmncgAcllUw7LX
	 CdRTkSX5gddBHuZH77hg/NsNmGOjLSzVgwxPkRZRZFhIYoW/bu7wAtHd0eNaZfhj4GW+MktaZAVr
	 ILlaFjxv9Fu6cIOBSeSz6/I1wjRUbjben8uErXzMYi+y6mUcYLh1ss6OmlQBD6Mngebcmx8Nj6hB
	 MvSyO+EM9K5Ss5xaKPMGyZMLl2h0gLC8H072e7+VJp0YZoZOBv1knT9PxvkiW8/blecDmrCyp95C
	 9VyF8XN5sseCdL0aM6GlULS/R40h0Pf7ssO4iLCbDn9Mko6cpwKvDo/3kjiX7t1qiet/XOF5vr+A
	 wsnY7z/0Oh9qDJ6FQ2rzyMvPnZHlyHou4EHpd/6JqoKWmE4aZsTerPSvbhiibf1VNlpzWh1JfAOL
	 8z1OWDJkr3aV1sSGrWiBzM73hqykPkbA1AKlmY2y5hobpuwDUzuJJ2mRDqhbmlqOPPraIkb8UY3W
	 MZJvkYuHZrVqUALsuKqjzEGzHfF+KHtCTc31MDTlZ49OYGP61QjdVIicJhecm1TeHehAlnKHXAM6
	 mi4mAdURpbDZxf7HaCa2rNXYlxzsdFNIBMQ/3970PQE+ToncJWFaZE+Wl2+4ZsHKvS1V19Ic3AvF
	 591vCbj+0cNw1+s/QjQYX3k4M0JE7KoMfnXNlkyQpIpKgojyCvmtZPL5fM6sXMb06ejEQprxCP0L
	 KQl/eAMEGPwBt16tY4qO+UkhyaD4anB5y/diPwAvAL4JOMkDO0C3IiQ0cH0mCM8vr90KNr052NHu
	 qCDPI0Iu7IiuuC7MD9/zz4ijZNbuvTC2D8STQyQEzVPgHdUEa9Fb4A4t46l7bfLsmloqWCQ/8YrQ
	 TrB8vYGvXdWOmEzWShIw3yzoRdh5ldbdiFbjqZFQI+QCOao++Lr64Ya/Tho6M7HyD8pLoEUanvSb
	 SF8VXcYHEVpMqy7LcM
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs-utils: tests: implement the calculation of checksum
Date: Sun,  1 Sep 2024 11:30:20 +0800
X-OQ-MSGID: <20240901033021.2124850-3-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901033021.2124850-1-kyr1ewang@qq.com>
References: <20240901033021.2124850-1-kyr1ewang@qq.com>
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
 fsck/fssum.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/fsck/fssum.c b/fsck/fssum.c
index b650641..9bcea1f 100644
--- a/fsck/fssum.c
+++ b/fsck/fssum.c
@@ -267,3 +267,247 @@ char* erofs_fssum_sum2string(struct erofs_sum_t *dst)
 		
 	return s;
 }
+
+int erofs_fssum_traverse_dirents(struct erofs_dir_context *ctx,
+			    void *dentry_blk, unsigned int lblk,
+			    unsigned int next_nameoff, unsigned int maxsize,
+			    struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_sb_info *sbi = ctx->dir->sbi;
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	const char *prev_name = NULL;
+	const char *errmsg;
+	unsigned int prev_namelen = 0;
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
+		prev_name = de_name;
+		prev_namelen = de_namelen;
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

