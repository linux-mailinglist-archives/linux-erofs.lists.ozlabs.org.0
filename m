Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA289A15C02
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 09:45:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZqty2TDpz3c3x
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 19:45:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737189944;
	cv=none; b=grnd333VU/8I6+Xla5PlzMOC2XfCGifapsDiqu4Zg6iDZEjSuTmpnpMpegVbmpxMaHYihg4gMv+c1+UdjA0ZG+jfL6EpFVUstTKPRj16HytYbWdGxkYZ/s6b1KZNdQ68uBHn88Xy8VlK5ehAmgSd8/j/95U24xhYZ2HsXY4qT4eVEWuM381DI60lOCpfcQM65HBd4nQpV4Jn0CZ4u4PiHcSyBWDn27AJXlU9Wm4/2yK9pToIKVyrHp/JC7ET/Jr4m7alyQa0WnQIq8LNCeTJlENdiZ9NXMEpL9vYdyZ4/Zs0V2AsBecg9wM7+if85fbiHHxfZrhTroVOYk8EJfGmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737189944; c=relaxed/relaxed;
	bh=ZnvZSifxCETy8EEzGo2CJYfb5AGXRfCxO5lzIAjsPMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnGv3EkYwS7TgIkGD+3IJHEMq9P9Byvc1Rogg1IJxmxCr04mw8kdmM2uRv+bw2jBC5zSawuiqXkWfFEbWcJju3+M7XNrGW86TP5a4Dtl/mcPE6o//X/hYXRuCWqcKN68USutRl9SU2WPpj5hP5pLGYfAjmSo7r5KWFa3/Xg7OseF4z8cSVC7YMIpGNtzFeDvPNBbeeE24DlMcz/dVikApk2AClJ1lsIRUOv0vJs2CDEk0hI8bcQY5jchUI6BvFjS79F3USQ7xMWIvJ1MMfSn9sO3SGkK8VXq5W5ZoGo+KK8tNDBE1eq9GuJue2xKaAHBZPYmGrMwjQz0Kva8k11biA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TKdhdJnB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TKdhdJnB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZqtv0TkJz2ymg
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Jan 2025 19:45:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737189937; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZnvZSifxCETy8EEzGo2CJYfb5AGXRfCxO5lzIAjsPMo=;
	b=TKdhdJnBr6emr0WWtZ6CdJWhiII/bFfjsyUm66CjjRyP740cNTwGo6M2LDazvWDyvkZm1gwg6Q1CmCieR2r/NBFP/YeFU4OdAbTqz55I5cuKuURdbS0GhHV57IDL57FiX4HqwZIUlq3ZwT3r4G17gRac7LIJa86vWU5iotW3niE=
Received: from 30.41.10.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNr.S61_1737189927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 18 Jan 2025 16:45:35 +0800
Message-ID: <963f880b-826f-4276-a73e-da5fdd02a6ae@linux.alibaba.com>
Date: Sat, 18 Jan 2025 16:45:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
To: Ian Kent <raven@themaw.net>, Chen Linxuan <chenlinxuan@uniontech.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>
References: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
 <9b2b5a34-cddd-41b2-9d1e-939b9f97b44b@themaw.net>
 <a9ab830c-241d-4a78-9909-9c986ad91741@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a9ab830c-241d-4a78-9909-9c986ad91741@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/18 09:25, Ian Kent wrote:
> On 18/1/25 08:45, Ian Kent wrote:
>> On 17/1/25 16:52, Chen Linxuan wrote:
>>> While reading erofs code, I notice that `erofs_fc_parse_param` will
>>> return -ENOPARAM, which means that erofs do not support this option,
>>> without report anything when `fs_parse` return an unknown `opt`.
>>>
>>> But if an option is unknown to erofs, I mean that option not in
>>> `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
>>> which means that `erofs_fs_parameters` should has returned earlier.
>>
>> I'm pretty sure than the vfs deals with reporting unknown options
>>
>> and returns -EINVAL already.
>>
>>
>> I think the caller oferofs_fc_parse_param() is vfs_parse_fs_param()
>>
>> and for an -ENOPARAM return will ultimately do this:
>>
>> return invalf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
>>
>> which does this.
>>
>> The thing about this is the mount API macro deals with (or it should,
>>
>> although I'm not sure that's completely sorted out yet) logging the
>>
>> message to the console log as well as possibly making it available to
>>
>> mount api system calls. I'm pretty sure this change will prevent the
>>
>> error message being available for mount api system calls to retrieve.
> 
> Actually no, removing the default switch branch does look like the right thing
> 
> to do, my mistake. The call to fs_parse() will return -NOPARAM so the
> 
> switch doesn't need to handle that case.
> 
> 
> Oops!

Yeah, actually dead code..

Thanks,
Gao Xiang

> 
>>
>> Ian
>>
>>>
