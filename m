Return-Path: <linux-erofs+bounces-3376-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHVfDqm3+Gn1zAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3376-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 04 May 2026 17:13:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE604C082E
	for <lists+linux-erofs@lfdr.de>; Mon, 04 May 2026 17:13:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8QC768QQz2yZ3;
	Tue, 05 May 2026 01:13:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777907619;
	cv=none; b=kSv/aZGwBPXlzYbzJLrWU5vpKWXWOM3O1jx0wCW7Mr3vyA3pRK335al2R4f6UuT/Qbt6cwndFEzAzI9HVE7lypCXohIE8mO7eLY4DHCXtH9Oil8E95/au5L+3sNcDlCoLyknKuxargcZQVRRiSzjs4gW0ACB0S8tPqitmCp0RB/KWK2Ws1cr7WyLGq8yiKSiukbMepsggtKoMwmOH1AzyPCDSK3/pJdzlw6KK/yZDzmEhOw8vMkDA9Hy/6TecpSvHrtk178S8hPhT3JYSPji4CskDi1gZx4l6QxbptyMrNEgrArXkOd7AWliPGdZotVYktdsK/rKjOyexH3qhEDeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777907619; c=relaxed/relaxed;
	bh=9AVAKeaFxmwdz50wEsCt0Kt1fBDQv/txcVtcMG9NNx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TLpfV9vTjVGowLz95D8bD0Q9IP1JezIrB+2nOX85/jZj7Zv1oJ8LD6b0QfY2tm7+rdlqCSfAedc+eyWbYNRS5tOk65ztblAv/DLQ+8/glP8rRRUIavQ+YGk9kI5shLbEOXeov41vvMyrzdJPguBqr+yWNLaFpMFycElSLcRXz4Qz8TNBGl25bNu6K9/2bu3E5J7nV6bqcw4TB5JzM5hgJBLWHNlbebna2kikSRDZPVA2jRn+n5ea826pRf1SGP8alcF7aqIjoK4cE3SXmCv3Eii51wJuCZJVl5ZYiTiCqKudyxNpQ0dwptvytQe+VpB76AK3c5hhDfopWVWrD+Ivgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HVN40wOs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HVN40wOs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8QC45pZXz2xfB
	for <linux-erofs@lists.ozlabs.org>; Tue, 05 May 2026 01:13:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777907610; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9AVAKeaFxmwdz50wEsCt0Kt1fBDQv/txcVtcMG9NNx8=;
	b=HVN40wOsirKx1trkvdRVQs8xr9heocA1qeaH5xWMIj2WOOq3UDo045AiT0wKQ5EBA13/Iv05QwCyilx94WLQqCsE/MOLWpYUztMeXRssWGUydWET7iiGvwyWXefrti7fi0O4uHgbzqDRIZuKk+q1BNNcLIx9nGPuiuLIFbv3YnY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X2CxnaR_1777907604;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2CxnaR_1777907604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 May 2026 23:13:28 +0800
Message-ID: <38546371-df53-4fa2-adf1-26ab2dd71542@linux.alibaba.com>
Date: Mon, 4 May 2026 17:13:23 +0200
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
Subject: Re: Rebuild mode for tail-pack layouts
To: xtex <xtex@envs.net>, linux-erofs@lists.ozlabs.org
References: <Jk-rGy7vS2y1kZoygWQp8w@envs.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Jk-rGy7vS2y1kZoygWQp8w@envs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 5BE604C082E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3376-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xtex@envs.net,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

Hi xtex,

On 2026/4/30 20:09, xtex wrote:
> Hi!
> 
> In erofs_rebuild_write_blob_index (rebuild.c), only EROFS_INODE_CHUNK_BASED
> and FLAT_PLAIN are implemented, so when generating a metadata index with
> rebuild mode, the sources cannot use tail-pack nor inline data layout.
> However, disabling tail-packing can lead to great disk-space waste in many
> cases, especially when the file-system consists of a lot of small files.
> 
> Thus I attempted to implement FLAT_INLINE for it, only to realize that the
> current chunk entry formats can only represent physical addresses that are
> block-aligned while tail-pack extent is not.
> 
> I wonder what do you think about adding a new chunk entry format? And how
> should it be named?
> 
> I would suggest the following structure:
> struct erofs_inode_chunk_index_tp {
> 	__le16 startblk_hi;	/* starting block number MSB */
> 	__le16 device_id;	/* back-end storage id (with bits masked)
> */
> 	__le32 startblk_lo;	/* starting block number of this chunk */
> 	/* new fields below */
> 	__le16 startblk_off;	/* starting block offset */
> 	__le16 reserved;
> } __packed;
> The 16b offset should be enough unless we are to support block size > 64K.
> The reserved field is added for alignment.

Sorry about the late response.

Thanks for the question.

FLAT_INLINE can be used for index rebuilding, which can work with
uniaddr (or mapped_blkaddr) since the blkaddr will be mapped
into the relative address based on the blob starting with
mapped_blkaddr:

https://erofs.docs.kernel.org/en/latest/ondisk/chunked_format.html#device-table

But I agree the expression in the page above is a bit
ambigious through.

Thanks,
Gao Xiang


> 
> Best wishes.
> 


