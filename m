Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D4A93D0C6
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 12:02:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YlM+/qtQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVjxD2Nt2z3dFm
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 20:02:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YlM+/qtQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVjx90Nd9z30Wd
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 20:02:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7E79CCE0B11;
	Fri, 26 Jul 2024 10:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B56C32782;
	Fri, 26 Jul 2024 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721988170;
	bh=y3T7leRy9u9hWhekWEnrvGtNeI2sgTWgG2gCnKSw2PQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YlM+/qtQGfI8YrQqvKEu3N134dL5tNaJ6MPGalYwca1ppGNZIIEv0FfqunTkVDk0G
	 z5lAB8Zyjd2QkiQ+G+FJgPfv2p52AHah8r+fzXfVmrXYZ/bHZj3xdxFP/hDjV2M/rB
	 PKtV+IoQMQu1pEU51ncTh3Paqyz6zDDFqMPLIf0iJQPeQQ8CXYaNybb0Z72MqX/S6G
	 2J12R5RlVZLEhWe2G9z6AX8vMkx/GbxtseDQD75nN8TFF4WaJ0dBJdI2NgtYoiVf+r
	 Lr4MwF9DfZ105rauj+gKANFn4Cwl+gDw0JEUFKju/T9k7UbIipEJPUU+slOzpcMdIM
	 YruHPjmyzSW9Q==
Message-ID: <0b16f00a-71d5-46f7-adc1-1f48f6e68745@kernel.org>
Date: Fri, 26 Jul 2024 18:02:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: convert comma to semicolon
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chen Ni <nichen@iscas.ac.cn>,
 xiang@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com
References: <20240724020721.2389738-1-nichen@iscas.ac.cn>
 <96238616-071e-43f8-9a14-5d4beab64217@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <96238616-071e-43f8-9a14-5d4beab64217@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2024/7/24 10:45, Gao Xiang wrote:
> 
> 
> On 2024/7/24 10:07, Chen Ni wrote:
>> Replace a comma between expression statements by a semicolon.
>>
>> Fixes: 84a2ceefff99 ("erofs: tidy up stream decompressors")
> 
> I think typos are bugfixes, so I will drop this label.
> 
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
