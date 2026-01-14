Return-Path: <linux-erofs+bounces-1854-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBAD1D06C
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 09:09:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drf0h06f2z2xpm;
	Wed, 14 Jan 2026 19:09:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768378179;
	cv=none; b=B4Qa/L5oBdGicb2S55YAIfQDKL44l8x9fc9d67nBeBx0bA3+Dmcm9vTlBiHAufElyo+JFLqMR8fFGrSRVgVdLWtxT7R80ykOq5fe1jDTMemw72R0dZ72X29mqdHiN0kWshOggChEpPMh7enWCneZDcxTkCMSbQdkRz8VWtNdSIPahcEap5qQoCHt1kG4mvok+oLDyn3PpVNx0wI6PmFDz65dFghLanx6DSm3WahECiQbWlC0yAo9swcCQluovecJTGisIN7QrR13g4wzIWEG4outf74LgVUutNR6MLUG6k8TmP7QTPqNgircd/Wf9LxjY66JYEgW7Owk/B/Z9RnXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768378179; c=relaxed/relaxed;
	bh=yqOFNTftqxW0qPWtLq/MPX3BwX5r4kAN1TtPHfumIvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzEzOrKVDkx/CWC65Nxh3Qg0K3fngCtjHjrgb8KSIQqaEtjFkxWP+9vTnH/VE3wpKHX/7P3KYkn02p71oNdE/EfTUTKmqtt24KegvYZd32CdmPfS2hvXR8MJp42C9Hexa50GpKGdEqj6gXeVWR/TwYPej/e1SbZqOpt585uVhHveNzEFuimh+i9BVoQgW7caj9/cNDkJQk23R4vOMzp3OHcGVzGkzLyMoeyzwDdwR/+8dxn7HZF9OCBt7qlgMxlSFpu3nvtK5I3oEKQFIXFZxnIxNo1V/k+QZhS2zPB4kbB2/FrceMrlOxhRAXFjyTYFgoQFvXMDmtCAz6nHkrKoyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hR1252E+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hR1252E+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drf0c6Stkz2xPB
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 19:09:34 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768378170; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yqOFNTftqxW0qPWtLq/MPX3BwX5r4kAN1TtPHfumIvI=;
	b=hR1252E+3b5QcuMXLsCkano9IK46sXfNFNTgUf4+3MuG7JW8yRq8BgorBQCTa4HEOYZhba1I5QsDO71tt81OiWbHEVgEV5QFRh7mZnJz9TTciZVo5o8HzFWw23MfJPcUuo1iBAJ6YmZ5sFAxyKNxUfFisqZ5L/NJWNJ30EpNbUo=
Received: from 30.221.131.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx1ZWSd_1768378166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 16:09:26 +0800
Message-ID: <8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com>
Date: Wed, 14 Jan 2026 16:09:26 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: correctly set {u,g}id in
 erofs_rebuild_make_root()
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <7db44e77-9256-469d-9845-d40079ab2a5a@linux.alibaba.com>
 <20260114073806.3640681-1-zhaoyifan28@huawei.com>
 <1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com>
 <0bc1baff-775b-4cf7-89f8-eaa22af10d9f@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0bc1baff-775b-4cf7-89f8-eaa22af10d9f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/14 15:58, zhaoyifan (H) wrote:
> On 2026/1/14 15:44, Gao Xiang wrote:
> 
>> we could support !im, I mean
>>
>>     struct erofs_importer_params *params = im ? im->params : NULL;
> 
> Hi Xiang,
> 
> Do we have any chance `im == NULL` in current codebase? Or is it to allow for future extensibility?

Yes, also I wonder if we could give a better name, like

erofs_make_empty_root_inode()

> 
>>
>>>       struct erofs_inode *root;
>>>   @@ -2384,6 +2385,8 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
>>>           return root;
>>>       root->i_srcpath = strdup("/");
>>>       root->i_mode = S_IFDIR | 0777;
>>> +    root->i_uid = im->params->fixed_uid == -1 ? getuid() : im->params->fixed_uid;
>>> +    root->i_gid = im->params->fixed_gid == -1 ? getgid() : im->params->fixed_gid;
>>
>>
>>
>>     root->i_uid = params && params->fixed_uid < 0 ? getuid() :
>>             params->fixed_uid;
> 
> will sigfault if `params == NULL`, how about
> 
>      root->i_uid = (!params || params->fixed_uid < 0) ? getuid() :
>                                 params->fixed_uid;

Sorry about my braino.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan
> 
>> ... 


