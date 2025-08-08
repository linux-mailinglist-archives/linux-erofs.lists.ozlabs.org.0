Return-Path: <linux-erofs+bounces-800-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46BB1E139
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 06:21:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byrSW1dbcz30WY;
	Fri,  8 Aug 2025 14:21:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754626875;
	cv=none; b=j3Zj1Y6wADaIGE1FY/n0kH7byhG2/XJq06vX1DKRy55MzOllNDZ1QjmlxTkg2yV21a7EeftkSvxgryHRT7OrvtYxW/15e56wp0sFFLNgkPIM2Zyb1gRwhMfDIYqbq5GoIfjwsMjNQTR6iJRm/lbnol5aR4BNmAVj0mUbvKd/9pE43T+A371oROpkBmJwycV+pZJRome5IEFPekfD+YNqnxNjqzauFOPW6D186L/2Nkgt2P+yCN4t7v2xstDAvxmYzIcEQAsh2y+3xrVLbBt00DIuTTUfUd87VqWRPZnvsvGPE8CN8GLeKn6PObS0xsdVJHfo8fIn+4K2OSzSKqLUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754626875; c=relaxed/relaxed;
	bh=NWV0i0xxdiOL53JQfIm20FDB5xnHvCaHFEer8cL8d/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRYdov66XUaSfOIr9y65mqsILmpuqhiv7dooa2LjfUVK0GZ+4KOPV2Xi2SSk77pA6VlSCIGxif5EBM+c4+n5aClUgZI3zgXeX8EVuxUlMG6OVu1S5Q3PfF+bcNorF17Q9yMCxVsS6IXDfW2+v/MBl9liGIbQublR2dZUYq5+DJXqKRdmIw9xebfhXEYwmQtftHbgRyP5JZij8WunZSmLfKoC5DNKmgNVy/Y1gF8/r7HuRmPVL7iZJM9YqaPSARJEkm3oNB3sYRGqq4QMLg1+Wdkx2p6QKXwJsaLtrWHq4ca+Lmtba3HIqLcnQfV1GKhD8o/whx5o9LlRviXGq/F8Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F30q4GTA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F30q4GTA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byrSR50dQz2xcC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 14:21:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754626864; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NWV0i0xxdiOL53JQfIm20FDB5xnHvCaHFEer8cL8d/A=;
	b=F30q4GTAJduQo/hPkJKpZv8ld3zTTUDyZwdqd7TXaNzq6WMxdMyfY5NOgqUfzl5Z1vhmEB2QqRmLLzmfTs1TJmk32jQ/WhaGPyrmtfi58dkGpaz2M4+pO7J4z75nQCF4o5L+COPNV1xM80FFkkTz13JhVKKWG6+8Kjwk3d8/O+U=
Received: from 30.221.129.72(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlG5bxw_1754626861 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 12:21:02 +0800
Message-ID: <ba783c6a-f333-408b-a227-79a649d96b25@linux.alibaba.com>
Date: Fri, 8 Aug 2025 12:21:01 +0800
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
Subject: Re: [PATCH v7 3/4] erofs-utils: mkfs: introduce --s3=... option
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
 <20250808031508.346771-3-hsiangkao@linux.alibaba.com>
 <3f0e8f62-5546-474b-93eb-e3bbd9f17d3c@huawei.com>
 <eeb4223c-f847-4f5d-8b00-4aa084f032f6@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <eeb4223c-f847-4f5d-8b00-4aa084f032f6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/8/8 11:52, Hongbo Li wrote:
> 
> 

...

>>
>> How about adding memset on buf? And we also need to add cleanup actions for s3cfg to free the endpoint and memset the access_key/secret_key memory.
>>
>> Therefore, after mkfs.erofs is finished, the ak/sk information will not be recorded in the memory.
>>
> 
> oh, buf is stack variable, memset is unuse. ;)

I will merge this series to -dev branch today, feel free
to submit any following improvement for this work.

Thanks,
Gao Xiang

