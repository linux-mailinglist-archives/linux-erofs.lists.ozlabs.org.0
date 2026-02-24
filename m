Return-Path: <linux-erofs+bounces-2380-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNeFMehInWk7OQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2380-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 07:44:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77418286C
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 07:44:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKp9w66tQz3cGZ;
	Tue, 24 Feb 2026 17:44:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771915492;
	cv=none; b=epseVxj2jRC3WJZV1R1nhDG8mKUZgcGCbB63Je02CWjb/r/n3qxvyqPEIe5B5G9XLU3FhQ3aiZEeHw/qNX6tuT/+lH9PGkU2SXCkSX8uHBQey/yKX/F5qwzq4f0OoN/p4mtEeTo6YLwqdtfd7KE+Jw1HMRaQggOmwoqk+LBaylPu5Z5tO3KP2lmUgUbautavwJ/q6I5Rzimp5RusOuWMUBpZRA9mgoyzxrjYacUW1vjXd6TPEMlCzmBnLEyIo3iTcvOpvkCTO8ffAlDuiF2c+45QDFVh4PL3RO+hqwZt3W++e2P7zQG+MnoNLED0ag+/1uiPsTUmCSvV6ppoIpvKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771915492; c=relaxed/relaxed;
	bh=rBtW8OXi2qrnPoLCuQKinlDOSi4AZ6szYHqIulHKpmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eDuaFEkRPJO2/i0S11GkjSDfLs9f/u+XGFtWroenuYJOiic0RAxLXbEhSV7X3LT0zo3GPEiPnUceZnduJcCxeeu/QkRDnhfpS56mimmJnSzYDknN8BtjLlNLEaCvgmg6VtsDaMFZdrFNp+LSfIO4dxIdBSH2FJZv6NfUurGwMX6aOxUf6BLLjsNb1HLEmIEBvzYFL3wv1EQjZ4NEQ7sUM6LERCLTJbrCdc7IdXkpVvGKbX8NrKa49zzWn9/0Htfly1MAbrK0I+zyXUnorX+BMgmENCupoiyfOm/LYLg/OuL88GclRaL/7/nAbT6nrfBxPcYU/3FEwrcpzEAXqbIHAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YYrLlK08; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YYrLlK08;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKp9s5rMwz3c9l
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 17:44:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771915483; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rBtW8OXi2qrnPoLCuQKinlDOSi4AZ6szYHqIulHKpmQ=;
	b=YYrLlK08iUG5mntZ9nOh1oWOyB4DyJpboc/h/B10Cw6+zkg7rSapHyd5EI7PRsVH/2Z842rDk43mmLDVtb1O69HDj+jDY0pNVnnhvHVyPcDRzVZZ0I43JW3MQsQbLZq2CcW3fVCcwDANQcoxAvji3gvGORD3u+hPEwS6GiDBhLk=
Received: from 30.221.130.254(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WziYTsz_1771915481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 14:44:42 +0800
Message-ID: <8a1690fb-4074-4eec-88df-ef7290e75529@linux.alibaba.com>
Date: Tue, 24 Feb 2026 14:44:41 +0800
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
Subject: Re: [PATCH] blobchunk: fix 48-bit format detection to use final
 remapped block addresses
To: puneeth_aditya_5656 <myakampuneeth@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <20260224055712.14110-1-myakampuneeth@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260224055712.14110-1-myakampuneeth@gmail.com>
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
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2380-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:myakampuneeth@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CE77418286C
X-Rspamd-Action: no action

Hi puneeth_aditya_5656,

Could you format the commit message instead of leaving
the commit message empty (maximum 72 chars per line).

The subject needs to be fixed as:

erofs-utils: lib: fix 48bit addressing detection for chunk-based format

On 2026/2/24 13:57, puneeth_aditya_5656 wrote:
> ---
>   lib/blobchunk.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index a051904..9b8112b 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -154,6 +154,19 @@ int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
>   		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
>   
>   	chunkblks = 1ULL << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
> +
> +	/* check if any chunk lands above 32-bit range once remapped_base is applied */
> +	for (src = 0; src < inode->extent_isize / unit * sizeof(void *);


I think it's too late to adjust inode->u.chunkformat,
see erofs_iflush():

I think you currently just add a new function like:

erofs_inode_fixup_chunkformat() {

	u64 extent_count = inode->extent_isize / unit;

	_48bit = inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT;
	if (_48bit)
		return;

	for (src = 0; src < extent_count; ++src) {
		if (chunk->blkaddr == EROFS_NULL_ADDR)
			continue;
		if (chunk->device_id) {
			if (chunk->blkaddr > UINT32_MAX) {
				_48bit = true;
				break;
			}
		} else if (remapped_base + chunk->blkaddr > UINT32_MAX) {
			_48bit = true;
			break;
		}
	}
	if (_48bit)
		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
}

Also if we really would like to fix this, we need considering add
a testcase for this, possibly use `--offset` to make the image
exceeds 32-bit, see experimental-tests.

Thanks,
Gao Xiang

