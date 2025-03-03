Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C596A4B7BA
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 06:50:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5nw23jSHz30W7
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 16:50:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740981009;
	cv=none; b=cRgL4W5dfY0rvNWYu9+oanQ1HqQI67voWNoXUVlR19lZ4KqPkZ+Rak7SSl12GBaJlf1dbzrIIpmQc8RxNRl0Hlk5oWXSvfBpJhDPzA9XIhq740ZeIfulahrLDSBrahBAGCNr6HjUkk1GP/FGI2C1qMFlbmhcR0PxxaJWEhLGU1I4W3pNUkY0hnC9n8LWFPwiyeRT9DaTzRP4D1BKiRrRnEV9m8TcqCrf7gtxKC99gHnxX9+j36tKCZ9k46M69ZtXgqILNIFAW5VejRDmlBp5OnpA7HUYzRvMLgcl6x8DKH39ci7byQQD1+nH/ZuFwuzNywwcI2/XgFv0cmq8WqRi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740981009; c=relaxed/relaxed;
	bh=c9e+P308Rn5hAfgbA+vkC4sRxHiM6O1+XU8kwheFlwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D6XpBPo/8obwMvKAi9Ytva17sR4y7ZLli0SAL/zI7yvc2KpzAfi9LncNq4W6oSKNQVLfo1bkf+OalkAT9O1mAOJ0J2sJZWjm2X+gWLDGJ3GiFMfrNNGzgXmM1YU2G4vBnxftOnNAJXy9mOydwVJW+ASlTkTJYY2QtqgEa1Gq3UoblDVi2D7akS9uczibKXFqBqD0dfFkPlTqYEvZgbEuGJHQIB0SkXuSSmWtGqEh9G8Ip3ds7X3r0Gray1Hr7C+Q0BbtIiGS3E1MNBY+B/YnzSnY5ARU4BbmVdmKgfAeckXRn6mpjL5xFfZZGkRHDq2JDDc/dBYVGtn5cAz94CFaMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RsmrPxWk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RsmrPxWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5nvz1k56z2xjQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 16:50:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740981002; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c9e+P308Rn5hAfgbA+vkC4sRxHiM6O1+XU8kwheFlwM=;
	b=RsmrPxWkS/bPSTENRppppypW1ThL/eckUAyqB2/Bke0kUxKfTC5L7tostYp8QkCt3S9HztFIth0AgVQzKZGzGW1ibrWFzzEDSpTTf37xx8xi79g076UEth2VGRxWSKOCEgpNIt6PTaIWhJbGyaGkzgkddXmm1l+rzN9kTFL91GY=
Received: from 30.74.129.132(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQZ0-Qb_1740981000 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 13:50:01 +0800
Message-ID: <feb5aae2-d2d9-46bf-8146-8d952a3b889d@linux.alibaba.com>
Date: Mon, 3 Mar 2025 13:49:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix inappropriate initialization in
 cache.c
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250303054253.1154648-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250303054253.1154648-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/3/3 13:42, Hongzhen Luo wrote:
> This patch fixes the inappropriate initialization of `dsunit` and
> `bktmap` in cache.c.
> 
> Fixes: 8bb6de4e7c41 ("erofs-utils: mkfs: support data alignment")
> Fixes: ca0f040f98b6 ("erofs-utils: lib: use bitmaps to accelerate bucket selection")
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Nice catch! Applied.

Thanks,
Gao Xiang
