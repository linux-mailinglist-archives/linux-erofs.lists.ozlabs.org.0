Return-Path: <linux-erofs+bounces-1295-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3DAC12931
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Oct 2025 02:42:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwY5Q56rDz3fmc;
	Tue, 28 Oct 2025 12:42:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761615722;
	cv=none; b=oWAzJDyXuDEZ2kWH3LuGcDin5epd+UWeEKNSqxhBMpF7Z1qa1kZbVD6Fas/C4VkFScb08BTuGnbm/dEygJy9p2M0L21EA2HCZH+Dbnz5h3PjMXm5cP2vDg+p2XT8ZMBe7nLdCiJuEouiyXQuUs33dRFSMK8U5gvJfjDWpHOnQbZ+ozkRgcYzTJmI8iJMB45LHxd+mFkOUhOE0C3Crm62ntL3x93taH2ENbbez4Qj0afFJPJ+EnyZHBYjNsyZclfrEF3gcK9Apeg5tJRp3Xg/jhqZr5i+uif1BavhHR0h6Tx9YcihQ88JqsVGyAt13Xtt8sk0hF9Z+xVwhBWpSA+WuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761615722; c=relaxed/relaxed;
	bh=WpW5GdsrBqmMkOlcLXktajSNHi5RsTqmt98mHQBMgIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMA9avVz/+T9Yz5ckuLWTonb3wmIWRUHZOQ+5kz34Q9EV3SuzS9/4w8zEKN4UuoR/9DuuorZ1HV2UqlyP91C5BiWvs56KIYNb7eBURptB3vGXpgy5/Y99OtukQWwc76zRtOXguwn6g/gRwyVup0cIfGOR/1udVA3xSXFEhOZkova2QR4Oyx72dhAMmQFsmF9w1YLMuHVf7yGN3qLZLwa6s71iPeEpsCC8NfPxPM9rNrpco01eXO8jN9/vuPC4y+NhEWp+Mnx03USyCOhM777htqoAis4seYX7A2Oll3YjMvppETLDia0cjpO5zcGS6cjO/JHIjWSvqStJA/Iphs++Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cjPOxQEQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cjPOxQEQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwY5N3Jp1z3dTg
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 12:41:58 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761615714; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WpW5GdsrBqmMkOlcLXktajSNHi5RsTqmt98mHQBMgIA=;
	b=cjPOxQEQjI5UXP3HXLYDxjUoTa+YNSGT5RzVvBqn0gG/4MW2U1lcHV2xW5m6lYmiOOB+UdtdjuMJI4Ep/ofQMTQ+mxoKMgFvEA3l93bTC1DHrntqQSjqFFvtqMe5VGhB+l5pMlJnWjdB4vxdginAFZ3Kjmwt0ct6Yxm+n23ZVTE=
Received: from 30.221.131.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wr9xrGU_1761615712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 09:41:52 +0800
Message-ID: <f47e4ffd-cd60-4333-bbc2-b07cea66d15a@linux.alibaba.com>
Date: Tue, 28 Oct 2025 09:41:51 +0800
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
Subject: Re: infinite loop in z_erofs_zstd_decompress()
To: rtm@csail.mit.edu, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <50958.1761605413@localhost>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <50958.1761605413@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/28 06:50, rtm@csail.mit.edu wrote:
> # uname -r
> 6.18.0-rc3-00011-g31772dcc6abc
> # wget http://www.rtmrtm.org/rtm/erofs22a.img
> # mount -t erofs -o loop erofs22a.img /mnt
> # ls -l /mnt/x
> ...
> BUG: soft lockup - CPU#8 stuck for 26s! [ls:1309]
> 
> The "do" loop in z_erofs_zstd_decompress() never quits; some
> guesses about why:
> 
>   * in_buf.size and .pos indicate there is no more input available.
> 
>   * zstd_decompress_stream() returns 9 indicating that it would like
>     more input.
> 
>   * z_erofs_stream_switch_bufs() does nothing, perhaps because
>     rq->inputsize and rq->outputsize are both zero, but also
>     returns err=0.
> 
> #0  0xffffffff806ddbd6 in z_erofs_zstd_decompress (rq=0xffffffc6002f3308,
>      pgpl=0xffffffc6002f3750) at fs/erofs/decompressor_zstd.c:178
> #1  0xffffffff806dab54 in z_erofs_decompress_pcluster (err=0,
>      be=0xffffffc6002f3340) at fs/erofs/zdata.c:1308
> #2  z_erofs_decompress_queue (io=io@entry=0xffffffc6002f35c8,
>      pagepool=pagepool@entry=0xffffffc6002f3750) at fs/erofs/zdata.c:1408
> #3  0xffffffff806dba48 in z_erofs_runqueue (f=f@entry=0xffffffc6002f36e0,
>      rapages=rapages@entry=0) at fs/erofs/zdata.c:1804
> #4  0xffffffff806dbf00 in z_erofs_read_folio (file=file@entry=0x0,
>      folio=folio@entry=0xffffffc500145140) at fs/erofs/zdata.c:1884
> #5  0xffffffff8020adaa in filemap_read_folio (file=file@entry=0x0,
>      filler=filler@entry=0xffffffff806dbe6e <z_erofs_read_folio>,
>      folio=folio@entry=0xffffffc500145140) at mm/filemap.c:2444
> #6  0xffffffff8020d66a in do_read_cache_folio (mapping=0xffffffd602488588,
>      index=index@entry=0, filler=0xffffffff806dbe6e <z_erofs_read_folio>,
>      filler@entry=0x0, file=0x0, gfp=1051840) at mm/filemap.c:4024
> #7  0xffffffff8020d714 in read_cache_folio (mapping=<optimized out>,
>      index=index@entry=0, filler=filler@entry=0x0, file=<optimized out>)
>      at mm/filemap.c:4056
> #8  0xffffffff806d37ea in read_mapping_folio (file=<optimized out>, index=0,
>      mapping=<optimized out>) at ./include/linux/pagemap.h:999
> #9  erofs_bread (buf=buf@entry=0xffffffc6002f3910, offset=0,
>      need_kmap=need_kmap@entry=true) at fs/erofs/data.c:40
> #10 0xffffffff806d41a8 in erofs_find_target_block (
>      target=target@entry=0xffffffc6002f3a00, dir=dir@entry=0xffffffd6024883f0,
>      name=name@entry=0xffffffc6002f39f0,
>      _ndirents=_ndirents@entry=0xffffffc6002f39ec) at fs/erofs/namei.c:103
> #11 0xffffffff806d4440 in erofs_namei (dir=dir@entry=0xffffffd6024883f0,
>      name=name@entry=0xffffffd6025b88b0, nid=nid@entry=0xffffffc6002f3ab0,
>      d_type=d_type@entry=0xffffffc6002f3aac) at fs/erofs/namei.c:177
> #12 0xffffffff806d4710 in erofs_lookup (flags=<optimized out>,
>      dentry=0xffffffd6025b8890, dir=0xffffffd6024883f0) at fs/erofs/namei.c:206
> #13 erofs_lookup (dir=0xffffffd6024883f0, dentry=0xffffffd6025b8890,
>      flags=<optimized out>) at fs/erofs/namei.c:193
> #14 0xffffffff802c575e in __lookup_slow (name=name@entry=0xffffffc6002f3bf8,
>      dir=dir@entry=0xffffffd6025b8620, flags=flags@entry=0) at fs/namei.c:1816
> #15 0xffffffff802c8a10 in lookup_slow (flags=0, dir=0xffffffd6025b8620,
>      name=0xffffffc6002f3bf8) at fs/namei.c:1833
> #16 walk_component (nd=0xffffffc6002f3be8, flags=1) at fs/namei.c:2151
> #17 0xffffffff802c93c2 in lookup_last (nd=0xffffffc6002f3be8)
>      at fs/namei.c:2660
> #18 path_lookupat (nd=nd@entry=0xffffffc6002f3be8, flags=flags@entry=256,
>      path=path@entry=0xffffffc6002f3d28) at fs/namei.c:2684

Thanks! Let me try to look into this today.

Thanks,
Gao Xiang

> 
> Robert Morris
> rtm@mit.edu


