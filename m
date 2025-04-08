Return-Path: <linux-erofs+bounces-159-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB4A7F904
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 11:11:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX0gd3Ks8z300B;
	Tue,  8 Apr 2025 19:11:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744103485;
	cv=none; b=MOsdsyY8XkvUgrwCewqF3lEG5Qc2VnpFEwl5gD3CfI8GTZQVRlE7k5qndvqHdEGi8Z8Ex2bhRw0ZKDdmUodxiht3WeW+lKpDr9iRXjOWB0uTIuyrGFXXWsYt8uMHkSjxyJkc/A+2kGQDAFC9q/auZ7b4D3c3v4BnsuZXPO3Pqo3FGxSWPBEqEvL0h7oDjkSk3H2zOrH70mIVmo6VlHYk4+HExzVL191XGetnGlHxp1L+lvHL73+T4aBc+YistipHK4wruyRRM/NYsm2nXvCvCmoDOTqaWz1UqLvOE6ezTLw4tuKcC+6hPKEJy9RMmYd62LpaxRrWXtZZ1TwaU0vhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744103485; c=relaxed/relaxed;
	bh=luGcT9UL4O/HTTEZuavQB4JaVAyjvuyVqOeWlRcydM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCBy9Jo6LCeyzJfmZJPC3NJVoWdt4Hpx4Uf6c04QKZbpgPpBIp/uz2GxpF0jKDGndES9LDu0hAalOxarKTM5M5O6D9YGwXNrY8Yc407e92uTjCze3LKZffk5ge8qFhCx2y+i34H9JoxBzZ7VkuyrEIixWM6J90nsMOJcj+5KLCwzHF0kaESNh+hIxtxrW9p4604nNjGDKMRTW9Jj7k7HnLx42DEOuYX47YRHEsfbOhGZkLC151ndTGEVjWceiY+73cRH8fbGilyleIRMsFWKmFqEOCwHPxzUyrCO69WwG5YJj9ph/CXYSFSWCXvbv9d/9ZEsU8f5UKY9e1LISr0zKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LiCkNx5y; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LiCkNx5y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX0gb3KdBz2yys
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 19:11:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744103477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=luGcT9UL4O/HTTEZuavQB4JaVAyjvuyVqOeWlRcydM8=;
	b=LiCkNx5ytv2eXJ1CMTbWuYAXJo3rMcZelmNWx/YQV4G5zRXcoZY6nK/Yd4kuixvdDykIVbiph3abywKnfIP28j6nNy8rHyu4CtvHjpmArTvM8hFS9I8MHxVN/D95hnvIpZpvU2xnpcQzt150QZAxVGFeFgkrzAvpA9K+HsLd9kY=
Received: from 30.74.129.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWEd0mn_1744103474 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:11:15 +0800
Message-ID: <98585dd8-d0b6-4000-b46d-a08c64eae44d@linux.alibaba.com>
Date: Tue, 8 Apr 2025 17:11:14 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] erofs: add 'offset' mount option for file-backed &
 bdev-based mounts
To: Karel Zak <kzak@redhat.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250407110551.1538457-1-shengyong1@xiaomi.com>
 <20250407110551.1538457-2-shengyong1@xiaomi.com>
 <7nupludayogog6jylmwnxwel4zlvfxeozzcg5qkf5g5a5fpt7g@3bgvpbqfuxxa>
 <d4eae031-8fbb-45e2-bdf4-f3a8a034b8ad@linux.alibaba.com>
 <gk7jzl7pktrdpznqp2hiuflx56xyttw4v4z3epia2ziw4oz547@cft7fyeoirfr>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <gk7jzl7pktrdpznqp2hiuflx56xyttw4v4z3epia2ziw4oz547@cft7fyeoirfr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/8 16:46, Karel Zak wrote:
> On Mon, Apr 07, 2025 at 11:49:31PM +0800, Gao Xiang wrote:
>> On 2025/4/7 19:40, Karel Zak wrote:
>>> We can improve it in libmount and add any if-erofs hack there, but my
>>> suggestion is to select a better name for the mount option. For
>>> example, erofsoff=, erostart=, fsoffset=, start=, or similar.
>>
>> Thanks for your suggestion!
>>
>> it's somewhat weird to use erofsprefix here, I think fsoffset
>> may be fine.
> 
> Yes, fsoffset sounds good. I anticipate more filesystems will support
> file-backed mounts in the future, making this option reusable.

 From my own kernel perspective, it's not possible for the majority
of read-write fses especially have nested transaction (like
`current->journal_info`) in addition to many deadlock factors
without extra workqueue contexts.  But for erofs it's safe.

Thanks,
Gao Xiang

