Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5FA14C92
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 10:55:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFTd48VQz3cmW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 20:55:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737107716;
	cv=none; b=iDdIz0BDX5svFCojxb0R55RLNOrnO4X3WxHLoSFi6wCgVRli2c70Yq+xaac69D9I/A+Jxg7SYVZ/2PBdq6sRfYO+Un4hkocEcvW8PQZnhNu6HGrHfSBscqEK+zw+M8J0vXf583R/i9oBnalP3DmiChaor0odn6qy9hVgzYyWWVJqv3jrt9HYEGFq/LTEmivDbzM1C/Mryr83OSW0xsQu/vlcW/98e7dT5F/kf5BbTAy05yhi5dMY7gzLTg9ViSBOp7MGEWRMgBpQyLF35CGIlrFgKOTWFtJLEldYUtd5JJsEPTmSryk0y8ULpv39WxK4J9zPiFpqvdgumXArfXjxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737107716; c=relaxed/relaxed;
	bh=Zgm57csXe3ohMYeCjXJ+yP1UaNYXfvtgJfFAoTH8JaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2yr83amyV3Yg13Qs5tHAipbHVOjCWUtqgXEjgPObjnUfeVoov7km+LcHnaCgXJ9frvAQbiyH6MaSU6fgBPu/IATdQwY1gw9NkiuA+DSuLIoBFBAwZPu+l0IYD92r+twGbiopzYY5Tys12u9VV+pRlBFYw1Xt5WaoGmmIgklPP3Fv2RobXdfKa/7rTbXr/yWqXs2Nwj3/dDyWsdG1w++yUu6zU8ORAuqXTp9hesZivwymfwYOZ5f4jmjsTG0nnL0H+29IY0tc8PbRQHDowvA9CulgZV7Y35nUqJNSuYi/KpuJ1pxdQOHzeDhqCjTvN7kYsDxQJZ23Wibap34ebhclA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Nrdz7oXi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Nrdz7oXi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFTZ43q2z2yD5
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 20:55:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737107710; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Zgm57csXe3ohMYeCjXJ+yP1UaNYXfvtgJfFAoTH8JaM=;
	b=Nrdz7oXiN4N31t/Wum2pWqmDJTbGeIMnle0jhYDRFqcV9j2jaM3No4T6T0+nX1dGlrTliLpHrG0EjikZWzvVAUE+0iHJTYoXhVjI/U1TnSP3JckCZqKgBDXqsRcUx5RSZXVZ0BZdpathJVCMT4rztlHqvsc0SsUB4oa6i2MssR4=
Received: from 30.41.10.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNoQt0I_1737107700 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 17:55:08 +0800
Message-ID: <58cadb57-22ce-4818-af2b-9ae452c38f27@linux.alibaba.com>
Date: Fri, 17 Jan 2025 17:54:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
 <649afa9b-5724-4b52-8b9b-9a82a3c1468b@linux.alibaba.com>
 <640C401CAB291F86+ffb78b4f37e75faf2b4730e625b8d72d15be782a.camel@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <640C401CAB291F86+ffb78b4f37e75faf2b4730e625b8d72d15be782a.camel@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.0
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



On 2025/1/17 17:50, Chen Linxuan wrote:
> On Fri, 2025-01-17 at 17:28 +0800, Gao Xiang wrote:
>> Hi Linxuan,
>>
>> On 2025/1/17 16:52, Chen Linxuan wrote:
>>> While reading erofs code, I notice that `erofs_fc_parse_param` will
>>> return -ENOPARAM, which means that erofs do not support this option,
>>> without report anything when `fs_parse` return an unknown `opt`.
>>>
>>> But if an option is unknown to erofs, I mean that option not in
>>> `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
>>> which means that `erofs_fs_parameters` should has returned earlier.
>>>
>>> Entering `default` means `fs_parse` return something we unexpected.
>>> I am not sure about it but I think we should return -EINVAL here,
>>> just like `xfs_fs_parse_param`.
>>>
>>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>>
>> I think the default branch is actually deadcode here, see
>> erofs_fc_parse_param() -> fs_parse() -> fs_lookup_key() -> -ENOPARAM
>>
>> then vfs_parse_fs_param() will show "Unknown parameter".
>>
>> Maybe we could just kill `default:` branch...
> 
> ext4 do not have a `default:` branch, but xfs return -EINVAL.
> 
> I think `default:` branch can report error when `fs_parse` or
> `erofs_fs_parameters` goes wrong.

How can it go wrong?

Thanks,
Gao Xiang
