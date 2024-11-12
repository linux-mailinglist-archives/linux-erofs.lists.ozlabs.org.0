Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 660369C5AF1
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 15:53:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnqCd3CnYz2yhg
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 01:53:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731423179;
	cv=none; b=CVp6pN5Zlaz7e1TKbyQjy6oAAp9+yR6OC46jfzrB3OcZKiwBlrB34AMjMGspPlfDU2WFA9849WASWodXQx3Ka8xowo5E77CT4GjOGZWJLnSNbZFS5N29E8rXM+qeF4BOBz74vdSm86OwKvIBidEznW0HpOp7XY9nrIfonXpFz+n2ojPM4trVk0yFGI+YH38qUhK3+0mwy76Lu0ZUeQOHmBGb6yTj/OgceZdkSDaYRzz+QC6efVY1sRp9GTJYmp9AVQ2r2FhFJ/wKkL5Iey6LbxjiFSvPNb0FLu0uoWJuLhIfMD+xI4WkoI9VS2vPbpjQlMnx8uqs2fg/5jTdzdw3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731423179; c=relaxed/relaxed;
	bh=vE+JwG8zv38SHYNxLdW3R5Zrf/tVbUHIVh7qpmzrCqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwRcwNiUcQUXyRv0/DZLciEhxLWb+3s8OMPSvMmFcmxjEr01meakoRgC+1pf3S0BnqRg45HRffAFWqUNzFt0rKa7HdFpi6OqorO+e3q+o8zn3jwwhkWGrqjke/8GxONxW4Xfca1ZxcLuaXCHAfyqS0HdVTvlKRAkLJsj1iChMW4XgduhA+AYWXTPjM6P33lHduwGDG54HTfxXzJZLlN4OJ3gM1gbvBsugOpFKNF9I2XftyKgOoyEDnxWqpviYTkzITjh6giupvp1mjt0vLEzyir/yLLWTpmjEUX2TNsy4uAiP8UjrhQByD9W3P1RWahxTNfvtcg0HKBG3om8OgYkDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mlAE6uio; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mlAE6uio;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnqCZ2lLvz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 01:52:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731423174; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vE+JwG8zv38SHYNxLdW3R5Zrf/tVbUHIVh7qpmzrCqw=;
	b=mlAE6uiozByj30HlZ1MP00zoHsXCd+0TRvriv62oG4BgSU6XzlHC1vucnWpF1eMhRv1SDuq8z8FnbyKEheOih+z4fbiOyPTqfi5OyrSwrQquWvm/nx+wa7cW8rBaWLZ/eRjfCE70v/1+IBkS3/wf4lf2r4QAuJAcXtSBDsG3U3A=
Received: from 192.168.88.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJHtqWE_1731423172 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 22:52:53 +0800
Message-ID: <c81653d8-ecf9-4b2b-997d-20b6c5b6668e@linux.alibaba.com>
Date: Tue, 12 Nov 2024 22:52:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mkfs: Fix input offset counting in headerball mode
To: Mike Baynton <mike@mbaynton.com>
References: <02a3a22d-782b-434b-b3e6-5138f77ee251@linux.alibaba.com>
 <20241111164819.560567-1-mike@mbaynton.com>
 <71572068-5a5a-4e5f-a1b4-b7f5ed24244d@linux.alibaba.com>
 <CAM56kJQpLyGhhGdsnJ2P-xgFbhNqzwdzUT2Qu6bfq=uAxGr0Zg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAM56kJQpLyGhhGdsnJ2P-xgFbhNqzwdzUT2Qu6bfq=uAxGr0Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: sam@posit.co, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/12 22:50, Mike Baynton wrote:
> On Mon, Nov 11, 2024 at 7:05 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Mike,
>>
>> I will add "erofs-utils:" prefix to the patch subject but no need
>> to add "Co-developed-by" tag.
>>
>> Btw, if some converter for headerball files from tarballs is
>> available in public? It'd be better to get some tests for this
>> feature.  `ddtaridx` is designed by some other team in Alibaba
>> so I don't have a valid simple generator/converter too...
> 
> The converter we've made is in Go, could that be incorporated into your tests?

I guess not... Currently erofs-utils has a testset:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests

I guess it'd be better to have a simple C converter anyway
to avoid extra language dependency for now...

Thanks,
Gao Xiang
