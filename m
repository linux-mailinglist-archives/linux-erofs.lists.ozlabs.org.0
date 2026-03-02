Return-Path: <linux-erofs+bounces-2460-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE8ODz+rpWmpDgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2460-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:22:39 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86E1DBBC5
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:22:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPjNV4phNz3bkL;
	Tue, 03 Mar 2026 02:22:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772464954;
	cv=none; b=kf9ztFtvGMsKW3vN2htor9iwWDPuTY7i6kub3TtK+BIB21ImZDd1WBtyipbzw3UDo0hBwHvMJy9I0++s+PYOFp5KRB5g7qiD8NPBUv7F3JEIb+eIUVqdKnw6cJ3zMJzo0WBiaukraoibdFWD4kB7bulTaoe89aK2GRCZru1vJ0w/V0DFplrBJUHNIqswtkg2QRit7UtPDWbajaLhP8BG/AI7iSFYudc+8VJoOVGm9JwxSgkEkJOgytT5rKAWPNPUE4WH+7kaOnmi6cRZhPzfRuVOkxbt2s7J91eFHOF//VwCEDlcmtfrSjc2q7djQizvZgQLSnp8Mupf62KIJaTG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772464954; c=relaxed/relaxed;
	bh=Nk1hh/fpLp3uQY8IqWsC+f3tiKfDEdk7cv25PWaf8q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b++l6rH4ORmPmx6PawwfC4i14cqN5jw5KNkls0j5rClaISrLY26X83KjQGcMY3jzFiF527acnB6R453NEeO1np5Ej32aF/67Cb4oPlKysBG19lPZVcgVdh3GyPWFXKmNMxPo00bFaG/06tzhR5SYQTyBynoADzeixhCwZM5Q7ggE9aXyru4mZl23gclxKWJGvo8I/zY3/mInh5gCfXzEoG5rH3G6FBuwm5MtuDHqC6I20KpvCp3/jWcX5cqolOMhxY0nnZmUEapI2/3aoA/W5eZauns19qtpXceAaYou/O15GkZhqjiLD1PMhrSALzqJjqI6MjeTWpMoklMKvS6Y2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Osh9hLqk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Osh9hLqk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPjNR4p45z3bW7
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 02:22:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772464945; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nk1hh/fpLp3uQY8IqWsC+f3tiKfDEdk7cv25PWaf8q8=;
	b=Osh9hLqkYrJ3LFGrMnwhVGqcFs9QnsQkSEB73AnUSGAyUtWrkpBFsdipLYZrUW7+sMB7wWAmvykrW/38dveGjs/cUxjfEHi4gN4/UopbC9nDm/fZmkfGWKPHhlvFp5j7f5Q3iHfupEYt3hSRgYE/IKKU9CxbzRBq1rh32IHXXJQ=
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-65GBL_1772464943 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 23:22:24 +0800
Message-ID: <7d8d63f6-d686-46a9-bf63-979662d0e96e@linux.alibaba.com>
Date: Mon, 2 Mar 2026 23:22:23 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix xattr crash in rebuild path when
 source has xattr
To: lishixian <lishixian8@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: qinbinjuan@huawei.com, caihaomin@huawei.com, caihe@huawei.com,
 wayne.ma@huawei.com, zhukeqian1@huawei.com, jingrui@huawei.com,
 zhaoyifan28@huawei.com
References: <20260302130356.769479-1-lishixian8@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260302130356.769479-1-lishixian8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: AA86E1DBBC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2460-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lishixian8@huawei.com,m:linux-erofs@lists.ozlabs.org,m:qinbinjuan@huawei.com,m:caihaomin@huawei.com,m:caihe@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,m:jingrui@huawei.com,m:zhaoyifan28@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,huawei.com:email]
X-Rspamd-Action: no action



On 2026/3/2 21:03, lishixian wrote:
> When rebuilding from source EROFS images, erofs_read_xattrs_from_disk()
> is called for inodes that have xattr. At that point inode->sbi points to
> the source image's sbi, which is opened read-only and never gets
> erofs_xattr_init(), so sbi->xamgr is NULL. get_xattritem(sbi) then
> dereferences xamgr and crashes with SIGSEGV.
> 
> Fix by using the build target's xamgr when initializing src's sbi.
> 
> Reported-by: Yixiao Chen <489679970@qq.com>
> Fixes: https://github.com/erofs/erofs-utils/issues/42
> Signed-off-by: lishixian <lishixian8@huawei.com>
> Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/rebuild.c | 1 +
>   mkfs/main.c   | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index f89a17c..f1e79c1 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -437,6 +437,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
>   		erofs_err("failed to read superblock of %s", fsid);
>   		return ret;
>   	}
> +	sbi->xamgr = g_sbi.xamgr;

`g_sbi` shouldn't be used in `lib/`, I think for this particula
one, we should set in the caller instead:

	list_for_each_entry(src, &rebuild_src_list, list) {
		src->xamgr = g_sbi.xamgr;
		ret = erofs_rebuild_load_tree(root, src, datamode);
		src->xamgr = NULL;
		...
	}

Thanks,
Gao Xiang

