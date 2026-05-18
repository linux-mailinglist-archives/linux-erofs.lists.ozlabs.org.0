Return-Path: <linux-erofs+bounces-3420-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOCmKIfBCmq87QQAu9opvQ
	(envelope-from <linux-erofs+bounces-3420-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 09:36:39 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8D567C73
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 09:36:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJqPJ0CCzz3c4V;
	Mon, 18 May 2026 17:36:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779089795;
	cv=none; b=I5KvukY0wP5iwFnvwTdRVG0nZ0n44jP8XzjHldk0J10MKaChO0MMe3Tvc21YIR8TwXGnKeXNDElLeAu7Qjw96A2dKC1Tv1C+bG71YHdR4pUvixG/m3JWdsOj1Ss9yp1CvNmFB3/ADpooYDlc6pSCHByh90pvX1nsdkoW2ps6GbZZJkU+4m2X3TVNGfk7lPwwrKV94I8KhHcSlDEfKfwsRHYHYswo2O/NqfjuY7A2RJXHn3z02t0KnyrftTya6Mv2lS2+pJFqE/+WN53kXE9um68w5fI2EUu4Ua8p0y9xboiaWnr6LaMI2pcCuHZKPfALte+CwFFT6Gcm57dh7i8Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779089795; c=relaxed/relaxed;
	bh=SZ8MdFlTLHaqmK13SLUQXcSKCXtOkWwlN3SrgUQkgtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcOsfLa7CM9m/NBzSDFT1EP0jTLcjoruksdnGpwjQjGLzUYkOv5zgtv22RA71xfoVMzQJgcKRNQ6W19O0vYU0Gio+rtJ4vWtD2Mlk+gQJsnR3+SJGX7RE3IT61Ln2njhLNRLChiH9xUnUZEgH2B6Nmmxgeo4I7TEjSbgSU0NR2T6sFyMW1PFuCVqIq6bgLdWggPPU0m3mweLe+LnAg35gipdtHhAJdgEKJFVPBAmSLBA+tuwOKBAgapF83Lu8P12Aec3/SIS1v/hYFk3lYpbOB7dk4YsqseHskYY7H/2SPdgcd0q4oXpMO7pVnWLs2N1rb9ZaAmUGM6OAlxpwE5l/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mK+OmZpm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mK+OmZpm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJqPG1y0Xz2yDs
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 17:36:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779089789; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SZ8MdFlTLHaqmK13SLUQXcSKCXtOkWwlN3SrgUQkgtU=;
	b=mK+OmZpmbiE1DtZjXUVec9bG4rV+zO1gACF27Q51FtSwx4zbdVW/VertEgo2vDgt6PB6SsM3L/gDPn7v5mxvm/pNHfrn3ItRqYu77aiTVtnE8gFI0vSXnkKS2ij3pEFyzvYDyCsK7p5gUWK4ADb8HB9VtpFyokL89Vvi9ySznac=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X35C-AD_1779089787;
Received: from 30.221.130.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X35C-AD_1779089787 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 15:36:27 +0800
Message-ID: <c85a5e6d-24ab-406f-b635-de9047261f10@linux.alibaba.com>
Date: Mon, 18 May 2026 15:36:26 +0800
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
Subject: Re: [PATCH] erofs-utils: mkfs: also handle last compacted 2B pack in
 z_erofs_drop_inline_pcluster
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, ke.wang@unisoc.com,
 linux-erofs@lists.ozlabs.org
References: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com>
 <e4701c42-1ed5-40a6-8f5d-927c40e3856b@linux.alibaba.com>
 <CAHJ8P3KB02f2dTWrMXtyBMQwfqmFEeOwa4SW8CKL-rKrE=Dg=w@mail.gmail.com>
 <91d164b2-adac-4f17-970b-698e500f84a2@linux.alibaba.com>
 <CAHJ8P3JUbP3woSH9sN8HKH4CVuX3iAdqK_iV6HeqtVD2DiHqoA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHJ8P3JUbP3woSH9sN8HKH4CVuX3iAdqK_iV6HeqtVD2DiHqoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: BED8D567C73
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-3420-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niuzhiguo84@gmail.com,m:zhiguo.niu@unisoc.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action



On 2026/5/18 15:28, Zhiguo Niu wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> 于2026年5月18日周一 12:18写道：
>>
>> Hi Zhiguo,
>>
>> On 2026/5/11 15:54, Zhiguo Niu wrote:
>>> Gao Xiang <hsiangkao@linux.alibaba.com> 于2026年5月11日周一 12:01写道：
>>>>
>>>> Hi Zhiguo,
>>>>
>>>> On 2026/4/29 15:59, Zhiguo Niu wrote:
>>>>> With ztailpacking enabled, the current process assumes that a compacted_4b_end
>>>>> always exists in the compacted pack. However, in some specific files, the
>>>>> compacted pack may not have a compacted_4b_end. This leads to an incorrect
>>>>> modification of the last compacted_2B entry, resulting in incorrect modification
>>>>> of its clusterofs. In subsequent fsck operations, incorrect parameters will
>>>>> affect the decompression of the penultimate pcluster.
>>>>>
>>>>> This patch determines whether the last entry of the current compacted pack
>>>>> belongs to compacted 2B or 4B and then updates the correct bits accordingly.
>>>>>
>>>>> Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression approach")
>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>
>>>> Sorry for late response.
>>>>
>>>> I do think the issue is valid, but either the previous
>>>> solution or the proposed one is ugly.
>>>
>>> Hi Xiang,
>>> Yes it would be ideal if the same piece of common code could cover
>>> both scenarios.
>>> But I haven't figured it out yet, so I'll distinguish them like this for now. ^^
>>> thanks!
>>>>
>> Could you confirm if the following diff fixes the issue?
> Hi Xiang,
> Just confirming a few minor issues：
>>
>>
>> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
>> index 9f3d0f9c35bc..0e4c2a9b53c7 100644
>> --- a/include/erofs/defs.h
>> +++ b/include/erofs/defs.h
>> @@ -218,6 +218,11 @@ typedef int64_t         s64;
>>    #define get_unaligned(ptr)    __get_unaligned_t(typeof(*(ptr)), (ptr))
>>    #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
>>
>> +static inline u32 get_unaligned_le16(const void *p)
>> +{
>> +       return le32_to_cpu(__get_unaligned_t(__le16, p));
>> +}
>> +
>>    static inline u32 get_unaligned_le32(const void *p)
>>    {
>>          return le32_to_cpu(__get_unaligned_t(__le32, p));
>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>> index 450e2647cca7..2cc9cc8009aa 100644
>> --- a/include/erofs/internal.h
>> +++ b/include/erofs/internal.h
>> @@ -210,6 +210,12 @@ struct erofs_diskbuf;
>>    #define EROFS_INODE_DATA_SOURCE_RESVSP                3
>>    #define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB  4
>>
>> +enum erofs_idata_type {
>> +       EROFS_IDATA_TYPE_RAW,
>> +       EROFS_IDATA_TYPE_COMPRESSED_DEFAULT,
>> +       EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B,
>> +};
>> +
>>    #define EROFS_I_BLKADDR_DEV_ID_BIT            48
>>
>>    struct erofs_inode {
>> @@ -262,7 +268,7 @@ struct erofs_inode {
>>          unsigned short idata_size;
>>          char datasource;
>>          bool in_metabox;
>> -       bool compressed_idata;
>> +       char idata_type;
>>          bool lazy_tailblock;
>>          bool opaque;
>>          /* OVL: non-merge dir that may contain whiteout entries */
>> diff --git a/lib/compress.c b/lib/compress.c
>> index 62d2672cb665..e171aee48c0b 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -483,7 +483,7 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
>>    {
>>          inode->z_advise |= Z_EROFS_ADVISE_INLINE_PCLUSTER;
>>          inode->idata_size = len;
>> -       inode->compressed_idata = !raw;
>> +       inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_DEFAULT;
>>
>>          inode->idata = malloc(inode->idata_size);
>>          if (!inode->idata)
>> @@ -980,7 +980,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
>>                                                &dummy_head, big_pcluster);
>>                  compacted_2b -= 16;
>>          }
>> -       DBG_BUGON(compacted_2b);
>> +       if (!compacted_4b_end && inode->idata_size)
>> +               inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B;
> if  compacted_2b && compacted_4b_end both are zero,  should not set this???

Yes, maybe it should be ahead of
`while (compacted_2b)`, and

if (compacted_2b) {
	if (!compacted_4b_end && inode->idata_size)
		inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B;
	do {
		...
	} while(compacted_2b);
}


>>
>>          /* generate compacted_4b_end */
>>          while (compacted_4b_end > 1) {
>> @@ -1210,10 +1211,12 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
>>
>>          h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
>>                                    ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
>> +       DBG_BUGON(inode->idata_size != le16_to_cpu(h->h_idata_size));
>>          h->h_idata_size = 0;
>> +
>>          if (!inode->eof_tailraw)
>>                  return;
>> -       DBG_BUGON(inode->compressed_idata != true);
>> +       DBG_BUGON(inode->idata_type != EROFS_IDATA_TYPE_RAW);
>   DBG_BUGON(inode->idata_type != EROFS_IDATA_TYPE_COMPRESSED_DEFAULT); ???

It should be

DBG_BUGON(inode->idata_type == EROFS_IDATA_TYPE_RAW);


>>
>>          /* patch the EOF lcluster to uncompressed type first */
>>          if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
>> @@ -1224,18 +1227,26 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
>>                  di->di_advise = cpu_to_le16(type);
>>          } else if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
>>                  /* handle the last compacted 4B pack */
>> -               unsigned int eofs, base, pos, v, lo;
>> +               unsigned int lclusterbits = inode->z_lclusterbits;
>> +               unsigned int lobits, eofs, base, pos, v;
>>                  u8 *out;
>>
>> -               eofs = inode->extent_isize -
>> -                       (4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
>> -               base = round_down(eofs, 8);
>> -               pos = 16 /* encodebits */ * ((eofs - base) / 4);
>> -               out = inode->compressmeta + base;
>> -               lo = erofs_blkoff(sbi, get_unaligned_le32(out + pos / 8));
>> -               v = (type << sbi->blkszbits) | lo;
>> -               out[pos / 8] = v & 0xff;
>> -               out[pos / 8 + 1] = v >> 8;
>> +               lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
>> +
>> +               if (inode->idata_type == EROFS_IDATA_TYPE_COMPRESSED_DEFAULT) {
>> +                       eofs = inode->extent_isize -
>> +                               (4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
>> +                       base = round_down(eofs, 8);
>> +                       pos = 16 /* encodebits */ * ((eofs - base) / 4);
>> +                       out = inode->compressmeta + base + pos / 8;
>> +               } else {
>> +                       out = inode->compressmeta + inode->extent_isize - 4 - 2;
>> +                       lobits = 16 - 14 /* encodebits */ + lobits;
> if  compacted 2B, lobits=2+12=14, but encodebis =14, clusterofbits
> should be 12??
> Or is there something I'm misunderstanding?

Not sure what you say, basically compacted 2B
encodebits == 14 all the time,

and the last item should be the highest 14 bits,

so

|                    16 bits.             |
| <----  14 bits ---->|
|  2bits |  12 or 11  | 2 bits
| type   |    lobits  | the previous item |


