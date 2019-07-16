Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 491666AD52
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 19:04:15 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p6F8029wzDqTh
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 03:04:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1563296652;
	bh=p0paQRGqMcW1qte+sH6HqXer0RYG7Dp4JUBxMGEfCN8=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=irgMJb2oMsc4ZIYTkfc29XsvpV4CRaJGUVlzRzXeGiytgtwzcV0+En0hEHQxGZ3kg
	 WKp6toxkBFR5ZhKCIAe1ItcgHGKseyw1LYPy4n9d8dPmlwYk5nMIZUzVeOXHEE6PPq
	 payLulL30SK6w7tx66a0NQ7oo1E5ggW5E6k4Nbyy431rcKbtkkeaZKl7nQQZZ5sqiu
	 QcyX8v0XEHhaPmXkx+7GEv7Ifw2HtDbb3Yz0yY/k1x8cXRN+LOdFOyNJT4Tulg/Zhh
	 LXTq1ZQJDwBNxj4Qcsa/ywwXUp94uWJQV9xotcuw2WEgO+VnuNCCAu+Op7zDngtI3N
	 /SxoDZg4DiWdA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.205; helo=sonic312-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="FdueOUrw"; 
 dkim-atps=neutral
Received: from sonic312-24.consmr.mail.gq1.yahoo.com
 (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45p6F04tYNzDqMk
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 03:03:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1563296635; bh=ygiJp5d84Y6OKu9ooqSLOOHRHRxexFfWbBmTLo4eP8M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=FdueOUrwNjwZPqBFxW43GGa5/lxD4Al1Z/zFwZKRIzZYlYOzdbiKTWVmHj7G5KC0asfFy4G3kIoQKqRO0qBp85IMsBLPZy5wts7CzKUeUfp4njMYGkx6KYwlHreOf176JtkL+u614RR7y6GhbZjoMV6iDFSotoimFtdfF1PtasIvQA6xvIqEWSJxgx0gFn5+Q9PP8xtRDEeRSpx5WcMxa7uGPnESbZr3k+kNlys6et5OypvPAiEKKiaDyA7Ua9Av5h1eWR08FVlh1rXqcY9qLRuNpvY89OdyT3DvegXPHiRYcybCMNR94efqgC+QDH2H4qFdXo0x0+bwfE5xGlW2Pg==
X-YMail-OSG: DzQlXE8VM1n.6BRt6BalfmpXntyZJum1dpXphEd5JTKxvJxFjzztHhPI4Bs_ZC6
 FbqQ9D9UdeeI8PO08E1iYb1ODc5j2Zpe_uJnZdqOVYKODHcdtqyCidG2jD3U43NiKIBq.CN7zdUt
 lNoQ.jm5PkDtn9xuwOx2HokCaKxlTPVG5DffS2VlqgY5LYR3rCjx5mroVlelXUbLFH3mW_UuK6nV
 xfVz2qep76jDjVPDh7bKJxKi_H1fZVtYR5VF9HK7stpumsVrEqcetj6u2B_.GNUn001LpcV0KcyU
 vDOkt7LhCa7qttYQubtmFUrpVEAZlsuHfjbbFCGxxDUCzBkRj3nvSc6f_dgFLIBD__MXel._9qVc
 YiL.22llT3vQog__zjwS.n2WrjBj6Hbqtu69Yf5AWifwm_6SwHsrSePQLR7QXcgXXcjc0qBQF32v
 mUG3eBftcER8QEcTX6SerB.VJQbUvKlaakyAUaVcSWEZ5J2bJft1ccSTSTa4QTQqIMpOf1UwexLB
 Ez6s8aMIw2PTR886lvehIXCTGFHf__HLtOfKgFDJrnKu8vyN_Yb.GMZIjjKGVxokPWE.EheeL2Sq
 NQp9PyKWWY3f7tOv3vsL1_0jOq9iHhxHe0KD2O6.zYtT0NkzJbDVFhM0O8yHrzFSiYScNq57VN8J
 1tBar4OAb.nwfTL9_NCRWuS3SXhp.unJ5ZcvnStjYPvndFN3t7XAU3jzYHEjvBzUBTfXvGvTg_Fq
 vrhJLQ0z7Ku8P3Ct0wuX24r8Y7mYEMf5HzjPmQ9x1E9yGoQUX7_qmn44z70IE7QuMUoJ6Z3Monpc
 Acn49mBsBhHi24EHdTgHVHnZhpAIK7XaR_O7XOD_0XDOp5Uu4m90YYgWZP8QILYy2KhJNsVRKjfZ
 pQjYV_27Q8elfmBbMy_mLBIEUNgon7P1DilPARuzcAmd1bSTD_WhNZBhN2.WH3vL.MlNFOA6C0WV
 DQfCgYJnxXAdQK1IS0wWas__etmEXRWt4rfVg6vi01gDAeeMZQDM5GmbaRlo1gPgoqRVaRkfK6Cc
 TJFBVZj4fVw2t9eZyUOZIuMVsTnyZLzC54iomHz7jmDGXEmC93q1osK2Rfs_NdsyzXX3Sxy.x2fY
 cLhnyDHE5aXuHYERFo7HQkwtnv5j222md77R_DpAlyR51yPXi4i5wAt6I9WYc7QLz7J661rLfJwj
 k.BZbeXWMm0r58Z.dU4qdiCM0N7bRAhzBRiu6mx4C.I6B_jIZqwvX
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Tue, 16 Jul 2019 17:03:55 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID c37a440bd67c8965aad6ae6be1583b73; 
 Tue, 16 Jul 2019 17:03:50 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: a few minor style fixes found using
 checkpatch
To: Karen Palacio <karen.palacio.1994@gmail.com>,
 linux-erofs@lists.ozlabs.org, gaoxiang25@huawei.com, yucha0@huawei.com
References: <1563294942-31395-1-git-send-email-karen.palacio.1994@gmail.com>
Message-ID: <1a0b5e37-a5a1-7a2f-0185-860a4aab4b2b@aol.com>
Date: Wed, 17 Jul 2019 01:03:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563294942-31395-1-git-send-email-karen.palacio.1994@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/17 ????12:35, Karen Palacio wrote:
> Fix camel case use in variable names,
> Fix multiple assignments done in a single line,
> Fix end of line containing '('.

One type one patch...

> 
> Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> ---
>  drivers/staging/erofs/super.c | 55 ++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 5449441..e281125 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -228,21 +228,21 @@ static void default_options(struct erofs_sb_info *sbi)
>  }
>  
>  enum {
> -	Opt_user_xattr,
> -	Opt_nouser_xattr,
> -	Opt_acl,
> -	Opt_noacl,
> -	Opt_fault_injection,
> -	Opt_err
> +	opt_user_xattr,
> +	opt_nouser_xattr,
> +	opt_acl,
> +	opt_noacl,
> +	opt_fault_injection,
> +	opt_err

NACK, all linux filesystems use Opt_xxx. EROFS should obey this practice.

fs/ext4/super.c
1436 enum {
1437         Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
1438         Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont,
Opt_err_panic, Opt_err_ro,
1439         Opt_nouid32, Opt_debug, Opt_removed,
1440         Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
1441         Opt_auto_da_alloc, Opt_noauto_da_alloc, Opt_noload,
1442         Opt_commit, Opt_min_batch_time, Opt_max_batch_time,
Opt_journal_dev,
1443         Opt_journal_path, Opt_journal_checksum,
Opt_journal_async_commit,
1444         Opt_abort, Opt_data_journal, Opt_data_ordered,
Opt_data_writeback,
1445         Opt_data_err_abort, Opt_data_err_ignore,
Opt_test_dummy_encryption,
1446         Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota,
Opt_offgrpjquota,
1447         Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,

fs/btrfs/super.c
 294 enum {
 295         Opt_acl, Opt_noacl,
 296         Opt_clear_cache,
 297         Opt_commit_interval,
 298         Opt_compress,
 299         Opt_compress_force,
 300         Opt_compress_force_type,
 301         Opt_compress_type,
 302         Opt_degraded,
 303         Opt_device,
 304         Opt_fatal_errors,

Thanks,
Gao Xiang


>  };
>  
>  static match_table_t erofs_tokens = {
> -	{Opt_user_xattr, "user_xattr"},
> -	{Opt_nouser_xattr, "nouser_xattr"},
> -	{Opt_acl, "acl"},
> -	{Opt_noacl, "noacl"},
> -	{Opt_fault_injection, "fault_injection=%u"},
> -	{Opt_err, NULL}
> +	{opt_user_xattr, "user_xattr"},
> +	{opt_nouser_xattr, "nouser_xattr"},
> +	{opt_acl, "acl"},
> +	{opt_noacl, "noacl"},
> +	{opt_fault_injection, "fault_injection=%u"},
> +	{opt_err, NULL}
>  };
>  
>  static int parse_options(struct super_block *sb, char *options)
> @@ -260,41 +260,42 @@ static int parse_options(struct super_block *sb, char *options)
>  		if (!*p)
>  			continue;
>  
> -		args[0].to = args[0].from = NULL;
> +		args[0].to = NULL;
> +		args[0].from = NULL;
>  		token = match_token(p, erofs_tokens, args);
>  
>  		switch (token) {
>  #ifdef CONFIG_EROFS_FS_XATTR
> -		case Opt_user_xattr:
> +		case opt_user_xattr:
>  			set_opt(EROFS_SB(sb), XATTR_USER);
>  			break;
> -		case Opt_nouser_xattr:
> +		case opt_nouser_xattr:
>  			clear_opt(EROFS_SB(sb), XATTR_USER);
>  			break;
>  #else
> -		case Opt_user_xattr:
> +		case opt_user_xattr:
>  			infoln("user_xattr options not supported");
>  			break;
> -		case Opt_nouser_xattr:
> +		case opt_nouser_xattr:
>  			infoln("nouser_xattr options not supported");
>  			break;
>  #endif
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -		case Opt_acl:
> +		case opt_acl:
>  			set_opt(EROFS_SB(sb), POSIX_ACL);
>  			break;
> -		case Opt_noacl:
> +		case opt_noacl:
>  			clear_opt(EROFS_SB(sb), POSIX_ACL);
>  			break;
>  #else
> -		case Opt_acl:
> +		case opt_acl:
>  			infoln("acl options not supported");
>  			break;
> -		case Opt_noacl:
> +		case opt_noacl:
>  			infoln("noacl options not supported");
>  			break;
>  #endif
> -		case Opt_fault_injection:
> +		case opt_fault_injection:
>  			err = erofs_build_fault_attr(EROFS_SB(sb), args);
>  			if (err)
>  				return err;
> @@ -525,7 +526,6 @@ static void erofs_put_super(struct super_block *sb)
>  	sb->s_fs_info = NULL;
>  }
>  
> -
>  struct erofs_mount_private {
>  	const char *dev_name;
>  	char *options;
> @@ -541,9 +541,9 @@ static int erofs_fill_super(struct super_block *sb,
>  		priv->options, silent);
>  }
>  
> -static struct dentry *erofs_mount(
> -	struct file_system_type *fs_type, int flags,
> -	const char *dev_name, void *data)
> +static struct dentry *erofs_mount(struct file_system_type *fs_type,
> +				  int flags,
> +				  const char *dev_name, void *data)
>  {
>  	struct erofs_mount_private priv = {
>  		.dev_name = dev_name,
> @@ -623,7 +623,8 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_type = sb->s_magic;
>  	buf->f_bsize = EROFS_BLKSIZ;
>  	buf->f_blocks = sbi->blocks;
> -	buf->f_bfree = buf->f_bavail = 0;
> +	buf->f_bfree = 0;
> +	buf->f_bavail = 0;
>  
>  	buf->f_files = ULLONG_MAX;
>  	buf->f_ffree = ULLONG_MAX - sbi->inos;
> 
