Return-Path: <linux-erofs+bounces-727-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB15B15C04
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 11:37:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsRvQ6rh5z30Vq;
	Wed, 30 Jul 2025 19:37:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753868242;
	cv=none; b=LC4yjo6nuRvSPGT55DasiSrNb1TJBUkV3T6+bcfIu26Eq3qNPhOBNylXU7hu5CEkan8n0g/bUE0PLNOz8pvdhUrCSlE+4ebaupW8JeBIDxnt/Ta9DW3G8fQSoP+8sbVnKKjjRbKz3cAZqCV+rMV6EymKte5DmR/RzDeG4FwdXnxCH7KtVvvalkHn72ZUfePhl8A5t8t6J6pNb34mvUFomR4HH/kNNiSm9MznXzNKIoNu6Co715lIu0/SRAHahQy/lL03hZEWFe+qKp8gyO6wz7xPcc5R+L8obE3Ek8eSUWGRSmxxj3htSuc42gWGC0Xf0QP9KvT0HUxiQOP560w7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753868242; c=relaxed/relaxed;
	bh=dXJeUxYzzLJ1dMnyTt5lhPRkEOgzdH9tVZqV63Ah1Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6cXU7PAlq3Zc10TtKMONJaU4cXqcUMOA7tugYyWk7e2xJ//OxqXIx+Wh8HMVLyzQXKZb5LPIAEloEA9EYNVuMsMFJMDT5V9Tp9fBypxSYDc3XupwKxMqf2CFSH2NlEt6xh2Se0k6Ia6RRzH8WYzBOlFw781sQp6X7pBRpyhPmYApuLvHODDRiVBFDK9ulo26U544I9I8vymwRaSvbOEtVBALM5A3iAMwFg1FHyri0MFOfmaKK1Z2oJRQBMvu656ytJ75dNifwgth9nvJrQhlYS/y5+DWPDyJJ4Tf/ztWilejWrHrgudiXQUcIEhym1hJ4XlooxOaPT63sl0Bmt8pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpEOoKoG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpEOoKoG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsRvN6Ymxz30RJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 19:37:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753868235; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dXJeUxYzzLJ1dMnyTt5lhPRkEOgzdH9tVZqV63Ah1Us=;
	b=lpEOoKoGvkS6YkUPrcy1+7/8lZ5pA/mc4Wzk4shSWo7prjmuZ3pXVj/vWfGY5oI+CFYRDre406bF6CU6NRUSpIooUD31rby7HfzsOUT4EASokcGK6iYt5bOru8oNMYBf4Xxrr7V9gT3g1wg1rjsTMWyMKhiKWXiLtc2lB6tg3jI=
Received: from 30.221.128.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkUOng3_1753868233 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Jul 2025 17:37:14 +0800
Message-ID: <e1a703c3-a651-4773-91ce-ead8a6d063bd@linux.alibaba.com>
Date: Wed, 30 Jul 2025 17:37:13 +0800
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
Subject: Re: [PATCH v2] erofs: Fallback to normal access if DAX is not
 supported on extra device
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Hongbo Li <lihongbo22@huawei.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <20250728045409.1678099-2-Yuezhang.Mo@sony.com>
 <469d7d39-dde1-41f8-9d72-1c1a30a2b577@huawei.com>
 <PUZPR04MB6316ED7ACB435DE4C592271B8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <PUZPR04MB6316ED7ACB435DE4C592271B8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/30 17:24, Yuezhang.Mo@sony.com wrote:
> On 2025/7/29 11:07, Hongbo Li wrote:
>> On 2025/7/28 12:54, Yuezhang Mo wrote:

...

>>>      if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
>>>              sbi->devs->flatdev = true;
>>> @@ -338,7 +348,6 @@ static int erofs_read_superblock(struct super_block *sb)
>>>      if (ret < 0)
>>>              goto out;
>>>
>>> -   /* handle multiple devices */
>>>      ret = erofs_scan_devices(sb, dsb);
>>>
>>>      if (erofs_sb_has_48bit(sbi))
>>> @@ -671,14 +680,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>                      return invalfc(fc, "cannot use fsoffset in fscache mode");
>>>      }
>>>
>>> -   if (test_opt(&sbi->opt, DAX_ALWAYS)) {
>>> -           if (!sbi->dif0.dax_dev) {
>>> -                   errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
>>> -                   clear_opt(&sbi->opt, DAX_ALWAYS);
>>> -           } else if (sbi->blkszbits != PAGE_SHIFT) {
>>> -                   errorfc(fc, "unsupported blocksize for DAX");
>>> -                   clear_opt(&sbi->opt, DAX_ALWAYS);
>>> -           }
>>> +   if (test_opt(&sbi->opt, DAX_ALWAYS) && sbi->blkszbits != PAGE_SHIFT) {
>>> +           errorfc(fc, "unsupported blocksize for DAX");
>>
>> How about using the info log? Can we consider using infofc in this case?
>>
> 
> This is not a case of error, I also think using the info log is better.
> 
> In erofs_init_device() and erofs_scan_devices(), use erofs_info() to output the
> logs of turning off DAX. How about using erofs_info() uniformly?

Honestly I have no idea how infofc()/errorfc() works on the
userspace side, it seems ext2/4 just use ext{2,4}_msg(KERN_ERR)
for example for DAX.

infofc() only has the only one caller:
cramfs/inode.c:         infofc(fc, "empty filesystem");

warnfc() has more callers:
ceph/super.c:                   warnfc(fc, "Value of option \"%s\" is unrecognized",
ceph/super.c:                   warnfc(fc, "Conflicting test_dummy_encryption options");
ceph/super.c:           warnfc(fc,
ceph/super.c:   warnfc(fc, "test_dummy_encryption mode enabled");
super.c:                        warnfc(fc, "reusing existing filesystem not allowed");
super.c:                        warnfc(fc, "reusing existing filesystem in another namespace not allowed");

I'm fine with either way, but if we follow ext2/ext4, erofs_err()
is needed too although I don't think the fallback should be
identified as errors...

Thanks,
Gao Xiang


