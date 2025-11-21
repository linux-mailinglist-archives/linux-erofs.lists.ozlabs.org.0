Return-Path: <linux-erofs+bounces-1418-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D4EC773E5
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Nov 2025 05:30:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCMh561B7z2ySb;
	Fri, 21 Nov 2025 15:29:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763699397;
	cv=none; b=ITyA6c0o57KcreEBZuYE8nCvS+4z4GXPN3fQB18pXYnBVXMJXx2LN0G37coNMjyvLdP6swSUtnnUNoTuCLu0lHaNdPxXQTH/toN/9fBGYc7SqgowIazTDRJejn/jtQ08408BA55vj3gXbPMGM19hYkh9/tdIFjT3MnadkQMjYQ0PFPbrhAWQWlgERxeuIyIqyP33EBggtFxkpafhKQs7nJk/9AckLmantFK5Sz3K7En0RNS2PcJ7tTRXZwDRBp2a6WTtmNUqRJnGjCpD1mApZRCux4dDAcWPiNI0opB67sRSxt/Bir7N/hU64eO5TtFqtacb9l86a0OlRk5WUS1W7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763699397; c=relaxed/relaxed;
	bh=lUkaoYS9MtxtwNYtPqlY1z+Phvth7Wxy9T76yQ4yfsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBChO77tks9qVQY2ve4EdRA9IS+jgEKtLIW/dJ0J0Gr2D6xPtUaOGs4MxSA+6Zj0iz1KvgSq+RMW7Wcbba95o8K09u7rqVMRNMZZDNOvIcl+gAVd8phT/3S/xg8qbk4kOgshcGDjalkC/Th6fx4qX2KKawyCuRrd+yxVd9Nw6oN20Epm3DcpEGuPvEQwyknNqd7t5fWWjgkBRlYjkTp5uTsfCyWDK9O31uYMwsXuO10XBwio8A2w3LhognBb+FICAh9qBro2K8Ipr1i1ie6tIBmiZbRE7Xkw+RUVSAXe9TRqLKEjZ5yG/LGc6pSwgYfS5no/f8OU9SU8OEjD82wQRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G1Fp46T/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G1Fp46T/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCMh16lLtz2yG5
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Nov 2025 15:29:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763699385; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lUkaoYS9MtxtwNYtPqlY1z+Phvth7Wxy9T76yQ4yfsE=;
	b=G1Fp46T/Vois7CKh7wpaY4HKBqW6TO5F5EokZt53aiSic13vX2x80wo76ArGHhNJ7y0eVc1grKR4eD2P1PfnW6CRaUQ1Is2arPSIpcMMUAIfROm3kfhTxqQuQb9tq+tZll2X2lm28HcLpYmveZ6byKZ6OgaWGeoRpzM20wTQT/Q=
Received: from 30.221.131.79(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WszYFdT_1763699383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 12:29:43 +0800
Message-ID: <86b0ce55-60f5-4bf4-84a8-6d612478baa3@linux.alibaba.com>
Date: Fri, 21 Nov 2025 12:29:42 +0800
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
Subject: Re: [PATCH] erofs: correct FSDAX detection
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com"
 <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
 <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
 <PUZPR04MB6316EBBEFB9F1878D1691E2481D5A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <PUZPR04MB6316EBBEFB9F1878D1691E2481D5A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/21 12:12, Yuezhang.Mo@sony.com wrote:
> On November 17, 2025 19:57 Gao Xiang wrote:
>> The detection of the primary device is skipped incorrectly
>> if the multiple or flattened feature is enabled.
>>
>> It also fixes the FSDAX misdetection for non-block extra blobs.
>>
>> Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
>> Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
>> Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/super.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index f3f8d8c066e4..cd8ff98c2938 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>>                  if (!erofs_is_fileio_mode(sbi)) {
>>                          dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
>>                                          &dif->dax_part_off, NULL, NULL);
>> -                       if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
>> -                               erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
>> -                                          dif->path);
>> -                               clear_opt(&sbi->opt, DAX_ALWAYS);
>> -                       }
>>                  } else if (!S_ISREG(file_inode(file)->i_mode)) {
>>                          fput(file);
>>                          return -EINVAL;
>>                  }
>> +               if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
>> +                       erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
>> +                                  dif->path);
>> +                       clear_opt(&sbi->opt, DAX_ALWAYS);
>> +               }
>>                  dif->file = file;
>>          }
>>
>> @@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
>>                            ondisk_extradevs, sbi->devs->extra_devices);
>>                  return -EINVAL;
>>          }
>> -       if (!ondisk_extradevs) {
>> -               if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
>> -                       erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
>> -                       clear_opt(&sbi->opt, DAX_ALWAYS);
>> -               }
>> -               return 0;
>> +
>> +       if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
>> +               erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
>> +               clear_opt(&sbi->opt, DAX_ALWAYS);
>>          }
>> +       if (!ondisk_extradevs)
>> +               return 0;
> 
> Hi Gao Xiang,
> 
> If using multiple devices, is there still file data on the primary device?
> If the primary device only contains metadata, the primary device does not need
> to support DAX.

Hi Yuezhang,

Currently we don't have a per-device/file fsdax selection
design/implementation.

If fsdax is on, for example, directory data arranged in the primary
device will go through fsdax path (but your case above is that the
primary device does not need to support fsdax.)

Anyway, in principle, we could make them work, but per-device FSDAX
needs a detailed design, I think we should restrict them on the
per-filesystem basis now.

Thanks,
Gao Xiang

> 
>>
>>          if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
>>                  sbi->devs->flatdev = true;
>> --
>> 2.43.5



