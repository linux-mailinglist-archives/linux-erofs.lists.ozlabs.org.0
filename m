Return-Path: <linux-erofs+bounces-2537-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDJrNTqxrmnxHwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2537-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 12:38:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA98238019
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 12:38:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTw4f4lDjz309P;
	Mon, 09 Mar 2026 22:38:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773056306;
	cv=none; b=jC82Jnf2Pi5XDNUav81BQoYlXt7W83TWBzGgqh3mjHj4azjALvArBdwpclfAvBySg3W7C+FJBYsQJkZYbmIg/NQmnio0aqYXpWHUvYle8kJ7F+WqSyRQCKDokYA3qvkfXsCzi9klHZafGu9S0BPRrAUpgU/rXMAUv+IrTUEhQDUsTJEt6DVHp3wWcwgpse0jdotiMhCI5W6jBgUtJ3lu/DMhHIRtLg0K6LMMMA2giNuHXwcfDE/vsRF6D61W6Bt9pbjizVqu7PaSwQMQODwWrA3mqH2Jrr/pPfvgAQ52hXVRdWFwh4Um1eALx8MTr28zu4l1A46CnQcGpnPVthclUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773056306; c=relaxed/relaxed;
	bh=E4k5hWwO5F0znN2YZSrPMRj1nTW+LX6/K45ocP45WOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jEAZOrIVUGEwnq/AJqWW8zSVK3HEF/Zx+Ejg1Q8BNJ2dS3r02+dYVvAieadSxvJgwWKs/68VX2kgUOZxzrnNxSEwzlWwx0WNCjr3ypHE6ektVxkbwuNvAhcNRj/VSHjsVE5vz6bU46hHVedi30/ZWG1HUqEDM1LSxA3Ey/6YZgh91QmDTJ3kQppn6pnYdI/VRwDALcA8r3gWdbvP5dL5MHL0p6nYBPhJSvVPBdsmI4WQ2Ko1mJRob6tMd3l2r8a3P91OY+jiEsH8+YDE5vfozXPkgX9yfIvzgtr5H/dxNLQ1dUkMNetkOp9E2xuo5cequIUVtFpnamKz/XMJEAqMpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ght/DhTP; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ght/DhTP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTw4b4hj6z2yFY
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 22:38:20 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E4k5hWwO5F0znN2YZSrPMRj1nTW+LX6/K45ocP45WOU=;
	b=ght/DhTPkvgxi/dZZXfmdlaVLnOn90foIZlcLaPpUxX4PI7kX87xCP2hpPrVZDx7eES5Fj5Xu
	aJkWVQYRuGlmgVZXME3nowxC2Osi1GhUgjj2mosC6DKUXVcpdAQRQLxDgf1M3MrjRacvchdIWpx
	xOG8HWE61C/6T4lV7PorkZo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fTvym1KRqzLlSV;
	Mon,  9 Mar 2026 19:33:20 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC5540561;
	Mon,  9 Mar 2026 19:38:14 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Mar 2026 19:38:13 +0800
Message-ID: <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com>
Date: Mon, 9 Mar 2026 19:38:13 +0800
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
Subject: Re: [PATCH] mkfs: support block map for blob devices
To: Nithurshen <nithurshen.dev@gmail.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <hsiangkao@linux.alibaba.com>
References: <20260307062810.19862-1-nithurshen.dev@gmail.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260307062810.19862-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 8CA98238019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2537-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action


On 2026/3/7 14:28, Nithurshen wrote:
> Currently, using --blobdev to specify an extra device is restricted from working with the block map chunk format. This was previously noted as a task that could be implemented by mapping the device blocks using a global address.
>
> This patch implements this support by allowing the block map to reference chunks residing on extra devices. This is achieved by:
> 	1) Removing the -EINVAL check in mkfs/main.c that blocked this combination of flags.
> 	2) Calculating the global startblk address for the block map by summing the blocks of the primary device and any preceding extra devices.
> 	3) Ensuring that EROFS_CHUNK_FORMAT_INDEXES is only set if the user has not forced the block map format, and adjusting the index unit size to EROFS_BLOCK_MAP_ENTRY_SIZE accordingly.
> 	4) Updating erofs_inode_fixup_chunkformat to correctly identify when 48-bit addressing is required for a block-mapped file on an extra device.

Hi Nithurshen,

Each line of the commit message must not exceed 72 characters.

> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>   lib/blobchunk.c | 34 ++++++++++++++++++++++++++++------
>   mkfs/main.c     |  7 -------
>   2 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 96c161b..2ef7462 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -159,7 +159,17 @@ void erofs_inode_fixup_chunkformat(struct erofs_inode *inode)
>   		if (chunk->blkaddr == EROFS_NULL_ADDR)
>   			continue;
>   		if (chunk->device_id) {
> -			if (chunk->blkaddr > UINT32_MAX) {
> +			if (!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
> +				erofs_blk_t mapped_blkaddr = inode->sbi->primarydevice_blocks;
> +				unsigned int i;
> +
> +				for (i = 0; i < chunk->device_id - 1; i++)
> +					mapped_blkaddr += inode->sbi->devs[i].blocks;
> +				if (mapped_blkaddr + chunk->blkaddr > UINT32_MAX) {
> +					_48bit = true;

It's impossible for 32-bit block map entries to support 48bit mode.

I think we should err out instead of enabling 48bit here.


BTW, it seems the erofs-utils codebase could not read a chunk-based 
EROFS image

with block map and extra devices (but in-kernel implementation could), 
as erofs_map_dev() does

not reset m_deviceid. Could you help also fix this? If you are 
interested please also add related

testcases in erofs/erofsnightly repo.


Thanks,

Yifan Zhao

> +					break;
> +				}
> +			} else if (chunk->blkaddr > UINT32_MAX) {
>   				_48bit = true;
>   				break;
>   			}
> @@ -201,8 +211,16 @@ int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
>   		if (chunk->blkaddr == EROFS_NULL_ADDR) {
>   			startblk = EROFS_NULL_ADDR;
>   		} else if (chunk->device_id) {
> -			DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
> -			startblk = chunk->blkaddr;
> +			if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
> +				startblk = chunk->blkaddr;
> +			} else {
> +				unsigned int i;
> +
> +				startblk = sbi->primarydevice_blocks;
> +				for (i = 0; i < chunk->device_id - 1; i++)
> +					startblk += sbi->devs[i].blocks;
> +				startblk += chunk->blkaddr;
> +			}
>   			extent_start = EROFS_NULL_ADDR;
>   		} else {
>   			startblk = remapped_base + chunk->blkaddr;
> @@ -324,7 +342,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   	chunksize = 1ULL << chunkbits;
>   	count = DIV_ROUND_UP(inode->i_size, chunksize);
>   
> -	if (sbi->extra_devices)
> +	if (sbi->extra_devices && cfg.c_force_chunkformat != FORCE_INODE_BLOCK_MAP)
>   		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
>   	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>   		unit = sizeof(struct erofs_inode_chunk_index);
> @@ -494,8 +512,12 @@ int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset)
>   	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
>   	if (sbi->extra_devices) {
>   		device_id = 1;
> -		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
> -		unit = sizeof(struct erofs_inode_chunk_index);
> +		if (cfg.c_force_chunkformat != FORCE_INODE_BLOCK_MAP)
> +			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
> +		if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
> +			unit = sizeof(struct erofs_inode_chunk_index);
> +		else
> +			unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
>   		DBG_BUGON(erofs_blkoff(sbi, data_offset));
>   		blkaddr = erofs_blknr(sbi, data_offset);
>   	} else {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 58c18f9..07ef086 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1565,13 +1565,6 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
>   		return -EINVAL;
>   	}
>   
> -	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
> -	if (cfg.c_blobdev_path &&
> -	    cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
> -		erofs_err("--blobdev cannot work with block map currently");
> -		return -EINVAL;
> -	}
> -
>   	if (optind >= argc) {
>   		erofs_err("missing argument: FILE");
>   		return -EINVAL;

