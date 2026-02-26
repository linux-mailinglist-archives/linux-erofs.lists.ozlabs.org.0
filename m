Return-Path: <linux-erofs+bounces-2418-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNlXNgynn2mHdAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2418-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 02:51:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EE56819FF28
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 02:51:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLvZ10XxHz30BR;
	Thu, 26 Feb 2026 12:51:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772070665;
	cv=none; b=dJCVGc8RsbHQkz5dJwhnHxg1oy1yhZqkogXDpTV02Majzfr/3i3TAvK0hgeQnHFS9Krd/IP8GegHhrBHQume/EZIYvJ7SJgV8h4CplCOFZO+Gi3ZfcS2T1UQ89mKbkIH0jSxFg49x+gHPH2H2dOzhw1/3KNO+8HIRVyJF5dRNgBtmFzMAY3NVrZVO89w2h59iobqW9PK5a3JgdIiY3k8WH2nimh6qKnLNCnTB/1M5OQ80EAMbh1V6UXjbVjjBl3Fs4KKTqM9vAD45CfgUIX/wdCknWXlhRw3R4av2NA0LwridEfUSfHf4k99wAU1cBCKYHSEUSNkHs+pE9o+T8TS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772070665; c=relaxed/relaxed;
	bh=ADQg/zheR+Yojk6P5DeKu80dYsxGlHmSbCVJo1b0tuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kc8jGRfzoIzNo9RRxAVT5yl5e7jQhOIU/0stdzLi4tMqsvn5b+ssV9d5XXqcIi8/iFTEbzxCG3Jx5zV9PsMl81zlSzMDIZnr7Czojn47mY9QmjMmg1T/b7ok1unMHycQzHYLbBPZiw8kaJzBq6iH+SiCmiu3FP/146rhgCzGuavXGjGv9gVzYcSaZmf5hKsZbctOnZCoFrn4aDsvIfG90xVLNKIaf/jPGFeh9Un77vRMbKMxTJVnxLgVmza2zdn6dYFSyMSTem7vh1/naE6kumHekABrsG7uK8tJk0h6iAykGAG6PdCSwKHRp+VQkbmctirnO08Djdzao+JCZ58Ccw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qwYeoDXc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qwYeoDXc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLvYy5r21z309y
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 12:51:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772070656; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ADQg/zheR+Yojk6P5DeKu80dYsxGlHmSbCVJo1b0tuA=;
	b=qwYeoDXcPWb86WunRb4/0wPCs4hz21tEaMzUcsOX0flcGbUsLmoWBAYuQzKmz3/zaxvMvjm85WDHOFsHwVMLhye6S+wRpuyCFprD4AWsRS/9GXoDKCIEuYKT2iTyadnevF1YsYlZCtlBxTVv8UtAeqnxHY8o6OdAgckbjw2m9c0=
Received: from 30.221.131.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzpTjXV_1772070653 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 09:50:54 +0800
Message-ID: <de02ce86-c2dd-491d-b418-087ddde5b31c@linux.alibaba.com>
Date: Thu, 26 Feb 2026 09:50:53 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fsck: support extracting subtrees
To: Inseob Kim <inseob@google.com>, linux-erofs@lists.ozlabs.org
References: <20260226005913.3703242-1-inseob@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260226005913.3703242-1-inseob@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:inseob@google.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2418-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: EE56819FF28
X-Rspamd-Action: no action

Hi Inseob,

On 2026/2/26 08:59, Inseob Kim wrote:
> Add --nid and --path options to fsck.erofs to allow users to check
> or extract specific sub-directories or files instead of the entire
> filesystem.
> 
> This is useful for targeted data recovery or verifying specific
> image components without the overhead of a full traversal.

Thanks for the patch!

> 
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>   fsck/main.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index ab697be..a7d9f46 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -39,6 +39,8 @@ struct erofsfsck_cfg {
>   	bool preserve_owner;
>   	bool preserve_perms;
>   	bool dump_xattrs;
> +	erofs_nid_t nid;
> +	const char *inode_path;
>   	bool nosbcrc;
>   };
>   static struct erofsfsck_cfg fsckcfg;
> @@ -59,6 +61,8 @@ static struct option long_options[] = {
>   	{"offset", required_argument, 0, 12},
>   	{"xattrs", no_argument, 0, 13},
>   	{"no-xattrs", no_argument, 0, 14},
> +	{"nid", required_argument, 0, 15},
> +	{"path", required_argument, 0, 16},
>   	{"no-sbcrc", no_argument, 0, 512},
>   	{0, 0, 0, 0},
>   };
> @@ -110,6 +114,8 @@ static void usage(int argc, char **argv)
>   		" --extract[=X]          check if all files are well encoded, optionally\n"
>   		"                        extract to X\n"
>   		" --offset=#             skip # bytes at the beginning of IMAGE\n"
> +		" --nid=#                check or extract from the target inode of nid #\n"
> +		" --path=X               check or extract from the target inode of path X\n"
>   		" --no-sbcrc             bypass the superblock checksum verification\n"
>   		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
>   		"\n"
> @@ -245,6 +251,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>   		case 14:
>   			fsckcfg.dump_xattrs = false;
>   			break;
> +		case 15:
> +			fsckcfg.nid = (erofs_nid_t)atoll(optarg);
> +			break;
> +		case 16:
> +			fsckcfg.inode_path = optarg;
> +			break;
>   		case 512:
>   			fsckcfg.nosbcrc = true;
>   			break;
> @@ -981,7 +993,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
>   
>   	if (S_ISDIR(inode.i_mode)) {
>   		struct erofs_dir_context ctx = {
> -			.flags = EROFS_READDIR_VALID_PNID,
> +			.flags = (pnid == nid && nid != g_sbi.root_nid) ?

Does it relax the validatation check?

and does (nid == pnid && nid == fsckcfg.nid) work?

> +				0 : EROFS_READDIR_VALID_PNID,
>   			.pnid = pnid,
>   			.dir = &inode,
>   			.cb = erofsfsck_dirent_iter,
> @@ -1033,6 +1046,8 @@ int main(int argc, char *argv[])
>   	fsckcfg.preserve_owner = fsckcfg.superuser;
>   	fsckcfg.preserve_perms = fsckcfg.superuser;
>   	fsckcfg.dump_xattrs = false;
> +	fsckcfg.nid = 0;
> +	fsckcfg.inode_path = NULL;
>   
>   	err = erofsfsck_parse_options_cfg(argc, argv);
>   	if (err) {
> @@ -1068,22 +1083,37 @@ int main(int argc, char *argv[])
>   	if (fsckcfg.extract_path)
>   		erofsfsck_hardlink_init();
>   
> -	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
> -		err = erofs_packedfile_init(&g_sbi, false);
> +	if (fsckcfg.inode_path) {
> +		struct erofs_inode inode = { .sbi = &g_sbi };
> +
> +		err = erofs_ilookup(fsckcfg.inode_path, &inode);
>   		if (err) {
> -			erofs_err("failed to initialize packedfile: %s",
> -				  erofs_strerror(err));
> +			erofs_err("failed to lookup %s", fsckcfg.inode_path);
>   			goto exit_hardlink;
>   		}

It would be better to check if it's a directory.

Thanks,
Gao Xiang

> +		fsckcfg.nid = inode.nid;
> +	} else if (!fsckcfg.nid) {
> +		fsckcfg.nid = g_sbi.root_nid;
> +	}
>   
> -		err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
> -		if (err) {
> -			erofs_err("failed to verify packed file");
> -			goto exit_packedinode;
> +	if (!fsckcfg.inode_path && fsckcfg.nid == g_sbi.root_nid) {
> +		if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
> +			err = erofs_packedfile_init(&g_sbi, false);
> +			if (err) {
> +				erofs_err("failed to initialize packedfile: %s",
> +					  erofs_strerror(err));
> +				goto exit_hardlink;
> +			}
> +
> +			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
> +			if (err) {
> +				erofs_err("failed to verify packed file");
> +				goto exit_packedinode;
> +			}
>   		}
>   	}
>   
> -	err = erofsfsck_check_inode(g_sbi.root_nid, g_sbi.root_nid);
> +	err = erofsfsck_check_inode(fsckcfg.nid, fsckcfg.nid);
>   	if (fsckcfg.corrupted) {
>   		if (!fsckcfg.extract_path)
>   			erofs_err("Found some filesystem corruption");


