Return-Path: <linux-erofs+bounces-3508-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G37iOQkEH2rfdAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3508-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 18:25:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8F6302C7
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 18:25:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=AeFzMKPX;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3508-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3508-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVGQs2FHjz2yFK;
	Wed, 03 Jun 2026 02:25:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780417541;
	cv=none; b=aFeb3QxltVPOooa+cNCF+omfsy8XyZKM74Pqb3ylX3C1Rqj/9ykiKVU2n53fi8OWLjo8Sc3nDM8NyUYpbm5GB26pdXY1maavmuey6zWRoY8hJGc3wNVZegWILuIlTR8wHXvUMcE23GdqjVHef7jbgJ13+A9zi4/4ePI3xAm/EjNeOJNSP27R9jwWd6mDHG14ToL8P3tsgymjG++l2Pj/Z2m4/3R+piDx8X/0yZP+Nqoozixgv/7rW+NCbBf0oapIBWg9BJbH1CxYK/Xn22+gGaN4bywYo9G6mlHVcQbizLGTYA5CVQSIIysrXmB2Qq4JBcKSb5fYQP7zdE+GzP3AxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780417541; c=relaxed/relaxed;
	bh=EpbqZJcq9Oh/PxoRgOKb2trtx+eeWnzATpjIZdwAlPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnY5SPfFbY16Xtb9Y17SYz/Dbm5/wycxWWFNwi3ETezbFtWKnthnLjxkrzliqW3NmhEBeBfg6TsEG6O5Ph4IslVVpY9rmP6jtiYGJ/aIzCPtRP9Nc/EtQ6o3Ap4eDngYDvsTXV5Zx7nTn5uzQO5dVz8hFf/8pVEGvKh5e8J0gC0VH9ovze6g9R+k2zm0Y2uRrm86+ImzLFI8PCInd+vGGH0m58/Dtf5YAZAV8jZXjXPlytjDebDQtnlyXMn+Pc13ruzYPoL3YA+iuhv/7hvvbQDjda5SAcGq79ThLj65Jq5UUB0y+Hp5TrNIcR6KhSzFy0GYVlj5WLmGzzH21JZfFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AeFzMKPX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVGQq1mtxz2xy3
	for <linux-erofs@lists.ozlabs.org>; Wed, 03 Jun 2026 02:25:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780417534; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EpbqZJcq9Oh/PxoRgOKb2trtx+eeWnzATpjIZdwAlPw=;
	b=AeFzMKPXnER48iU9MMg7Nb6NkESvyQXYSvUuGvw3wHEaPT43kD4D77OuOyRvWXzZ6FiWFIlCsgo5ZycLssbSut/ShM2zpOJ23ddkz0v/bGEQG/ZJtqxOkPbo+gfRhmIMkKqID667dmSUlFYpoQPPCmbRDUN+wSm3v/sB8vzxaks=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X44xNwS_1780417532;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X44xNwS_1780417532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 00:25:33 +0800
Message-ID: <7c5bfcf0-36a3-4cc6-bf31-6af4fc901c37@linux.alibaba.com>
Date: Wed, 3 Jun 2026 00:25:31 +0800
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
Subject: Re: [PATCH RFC 7/8] erofs: open via dedicated fs bdev helpers
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-7-bb0fd82f3861@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-7-bb0fd82f3861@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:hch@lst.de,m:jack@suse.cz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3508-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8B8F6302C7



On 2026/6/2 18:10, Christian Brauner wrote:
> Route opens through fs_bdev_file_open_by_path() so each external device
> is registered against the correct superblock, and convert the matching
> releases.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>   fs/erofs/data.c     |  6 +++++
>   fs/erofs/internal.h | 10 ++++++++
>   fs/erofs/super.c    | 66 +++++++++++++++++++++++++++++++++++++++++++----------
>   fs/erofs/zdata.c    | 10 +++++---
>   4 files changed, 77 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 44da21c9d777..5220585293df 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -69,6 +69,9 @@ int erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb,
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> +	if (erofs_is_shutdown(sb))
> +		return -EIO;
> +
>   	buf->file = NULL;
>   	if (in_metabox) {
>   		if (unlikely(!sbi->metabox_inode))
> @@ -236,6 +239,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   		}
>   		up_read(&devs->rwsem);
>   	}
> +	if (erofs_is_shutdown(sb) ||
> +	    (map->m_dif && READ_ONCE(map->m_dif->dead)))
> +		return -EIO;

Take a quick look at the code, maybe we can just add
the SHUTDOWN status only since I don't think remove an
individual blob device is useful for the typical image
use cases, so there is no need adding `dead` for each
individual extra device.

and just bail out if erofs_is_shutdown() at the very
beginning of erofs_map_dev()?

>   	return 0;
>   }
>   

...

> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 43bb5a6a9924..89ae91935364 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1697,11 +1697,15 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>   			continue;
>   		}
>   
> -		/* no device id here, thus it will always succeed */
>   		mdev = (struct erofs_map_dev) {
>   			.m_pa = round_down(pcl->pos, sb->s_blocksize),
>   		};
> -		(void)erofs_map_dev(sb, &mdev);
> +		if (erofs_map_dev(sb, &mdev)) {
> +			/* the backing device is gone; fail the batch */
> +			q[JQ_SUBMIT]->eio = true;
> +			qtail[JQ_SUBMIT] = &pcl->next;
> +			continue;
> +		}

It needs some injection tests anyway.

May I ask if it's an urgent 7.2 work? If not, I could
make a preparation patch for the upcoming 7.2 cycle
to handle erofs_map_dev() failure here so you don't
need to bother with this in this patchset.

I will seek more time to resolve the recent todos
yet always intercepted by other unrelated stuffs.

Thanks,
Gao Xaing

