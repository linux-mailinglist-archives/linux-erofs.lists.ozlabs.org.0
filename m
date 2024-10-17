Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 480839A1C40
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 10:00:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTgHW63Wcz3bgV
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 19:00:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729152021;
	cv=none; b=j/a6QJugj8sAfrDAGYUue32NO3AVI9xFu1VaRwz+yzdc0+OqKtlG/hy5d10VfryrbuJBiTijjeoSfyKPLbnN4YPAdfjjcYfqQYZ6zEv9aWtNuT90JHGrsi7DYZXxQMAjJMOOTWssmCMfuJRCKAl2+8jeidHH1HDCtxSCVrKhPWzgNl7PtnTST92DII0jbF9XxJzICQgeaGFgl+DvF7wI0CQe/BylKBygv0XLEQQvNFTI4HA1gJAJtgF1hkLvH37AyyPuHo2/Pg10kwe3Tnc3D13kOlj3vV3Kjw8A8lcS5GjfYiPuFsMF+SIrNNoKg0Xg5hat3XV67dYoVL4SbZ5mTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729152021; c=relaxed/relaxed;
	bh=dJCi/IDxX7C53L5q79zWTfQAlZqb4kThVsvTlrezeYw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GdWJBxMhBub8zA3PF3z7xJzC7TFRQNvxURX3YN1FyGmsciR99gskabqJPByqiC80xvo2PHwn/3Qpv2xAx1rpC/v06H3FzDdHdbo3opuoNh3juIuPxsIOxW1gjKkkSbwW7ISon4iTfrWR8KACWlgYElRYdxRjSluwAXMUqPYzE7wBwDHFVRaV5fGWKutw0MOjNO9DuE2WUGfeYCdKZsBhTaz6WfiBM7qP0iGyCFbHOtsoJbDbCPDA4+MCFC3LjE6EEZ0VMGz/DoRgSZ6Id+IBvcZeC2evL9oWliR1sH5sM0ZKLR83ufuOM3AYb6d5ZfRhcBaLmhrs7n8XyXvFSR4Y9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n7+tud2P; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n7+tud2P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTgHS4cpmz2xHx
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 19:00:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729152016; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=dJCi/IDxX7C53L5q79zWTfQAlZqb4kThVsvTlrezeYw=;
	b=n7+tud2PUh8jMlI1gyDe57haoEPQb5cPJslAOKCaw06LjVnwQDtZNCukGcDLQvrMAiGYjylQB1afyWe4QtljdpBM3Rz4siK5KyC8+X3nOuGeyNnFDUfSqTf36dRhB9h/qPypDXk9BaoEbx16XrYNT7dapMKqb0bUh8mI7FInrxc=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHK41XQ_1729152014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 16:00:15 +0800
Message-ID: <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
Date: Thu, 17 Oct 2024 16:00:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Barry Song <21cnbao@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20241017074346.35284-1-21cnbao@gmail.com>
 <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
In-Reply-To: <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Barry Song <v-songbaohua@oppo.com>, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/17 15:58, Gao Xiang wrote:
> Hi Barry,
> 
> On 2024/10/17 15:43, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> When a folio has never been zero-filled, mark it as mappedtodisk
>> to allow other software components to recognize and utilize the
>> flag.
>>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> 
> Thanks for this!
> 
> It looks good to me as an improvement as long as PG_mappedtodisk
> is long-term lived and useful to users.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

BTW, I wonder if iomap supports this since uncompressed EROFS
relies on iomap paths...

Thanks,
Gao Xiang
