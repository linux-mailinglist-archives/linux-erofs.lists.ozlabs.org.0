Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C8A135BF
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:46:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYc0G1z8jz3by8
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:46:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737017164;
	cv=none; b=hPy4BGmKPiGG2c68bTdnqKhRI0bmRX0jy0vnjTTgqVcHW3pvaq4welCN2gH/neX+Y3UXbtAxzw5Ucz1q7WZb7DWP94//mUtFxm99KrAxcIEYxiOUcL9rRU9LEOQzTNIO7nGd/MmpmseKTpU2TJ7F/3yqPLPMby2epJN1v+aBEgfZcSyRoJ+mQ8+Pnb4M+x0oQNnr3Sz3dKYGANfxNgtOYUm+XUKwSeTRBOUQ4YAjO2datLJnSp+QadWJC/no9Gt74bUeZ/i8jMuwg2w4oin4A1xHa68ZZXNSJEhZlYQ+SO93dYkojrlEvInFLnzPMBr8yEu4wM+OkVLarSODgMc5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737017164; c=relaxed/relaxed;
	bh=eDtRUsxJBjZAyQmblhg5+I7UGqi4KmE6IPlytR+KzFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPeMctDKXXvLH0Z9toYH6t+aC8hUn02zkQxqqr257p9Pi+a4rOGjc/4dpNZeVgDaQjGYq2fNaIUWsmNP1GZGpUBU61mZS3a6y6ACnsCcKRqQ2KDvAzAUEUCbtzPa9tcWaRgZn+HNdNR8Kv9+viXKdKJVq3Ir8duWHl+5BFbIIwyg8pG5CXxK1+dcRr8/K2+AiDyhog2M3wMkXSk3MlLgeClKymxcuRd4Upg5NzCTEmVQuGgilDUVTZwojNzBMqjKdtMd7xZTWvloSehp6IBD2IHwWVB9TAmnuV3HqAFEeftjDOzoSSF11qhMSgGmr1LMhifSrIUlTUbf9Ni3KUeyBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FTa6iedh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FTa6iedh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYc0C5Fclz2yJ5
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:46:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737017159; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eDtRUsxJBjZAyQmblhg5+I7UGqi4KmE6IPlytR+KzFs=;
	b=FTa6iedhSZ5dvW+Pehpil7saSCvmXjzPr6kx2HdOqy+qpE/RPimkMFNAtSct4h9pUnAxVvW+FkvRDgltN4gDa67wyLcjb/HR3Ctzc2Sc/HT0E56Thzcd5w+uqams3L5S4W095B9KWUsx5AqFwH8kV0veLCvs1hA6WS/WsHqyh1c=
Received: from 30.221.130.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNl2-Hv_1737017157 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 16:45:58 +0800
Message-ID: <2ce9821f-9059-4b2a-b9b7-880cece68e0d@linux.alibaba.com>
Date: Thu, 16 Jan 2025 16:45:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs(shrinker): return SHRINK_EMPTY if no objects to
 free
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <149E6E64B5B6B5E8+20250116083303.199817-1-chenlinxuan@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <149E6E64B5B6B5E8+20250116083303.199817-1-chenlinxuan@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/16 16:33, Chen Linxuan wrote:
> Comments in file include/linux/shrinker.h says that
> `count_objects` of `struct shrinker` should return SHRINK_EMPTY
> when there are no objects to free.
> 
>> If there are no objects to free, it should return SHRINK_EMPTY,
>> while 0 is returned in cases of the number of freeable items cannot
>> be determined or shrinker should skip this cache for this time
>> (e.g., their number is below shrinkable limit).
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
