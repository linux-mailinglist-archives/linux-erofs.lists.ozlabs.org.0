Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B8A13414
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 08:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737013372;
	bh=PPRijxdo+q4yeMHhuTIxpKD7m1hezMp6Xazc/8xpC74=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gsTC8eZT8vX09HRzgj+PRKmUTdJM0gwfN6b8+HEUcln4Hhg25iE70FU+9jGFPKV/7
	 EpqtE34XPId2LtKr08tCKs+xUBjKZvjEkmapqmMAwzyP2NZhJoV/JJ/duvz6/y/w39
	 ruE67nmQGIw5re/POHgV62zzoYLxtQVyCyAqbBqvlS67tLlXkLLXW4EOmrw209TBMM
	 2rB2oxhoWvr7tormRSX6Vc4GHTc6mKtc0Me/zs9qMfTaiWVebGCuYxwXdRuSLcF75Z
	 K3vycAWj4Ze7T/bmPRqvECDhZD+ivjAUNi4y8tCktXL9w8ylFcA0sbk5mihCTSnhqi
	 xFFprg+17yGnw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYZbJ34KRz3by8
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 18:42:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737013370;
	cv=none; b=fkO7LYty2VZy4+XXDo4M1tAP8Zqe6N2//PBn0o7L3R4BGJHQCWSdpAO4R6aZvPG/hVygrUU9e6W/3QjjWK22c3IHCamQAzac21UT5JVqFMR0VwhOHu1cOK3xsmkmj8P4QrS8gVitBqgCK1/kAfzpJ/WVKYmj4T9f7ecFHJf/cWKD04WYhUVz9thH7A2IakGSxClSlMJNSxLVBcTWo4uhD4+ssTCb5L/pHOz3eIog4JGxwH58hWnPhqnB8kBwGioz+V9rGyQJ42iN3Hx7gAjqyh48NjAeeEb4ll9xZqF0nQepfB+Q/Ek8pTEkPkozz3HwF4LdjwF1dapxSTXA6x6d8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737013370; c=relaxed/relaxed;
	bh=PPRijxdo+q4yeMHhuTIxpKD7m1hezMp6Xazc/8xpC74=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NyexHMKQS/7JFEl4EoQhPRC86dMOGlFmvHpn7r1HU+o8EHMRFlyEMlhbTlElyr3309SXP190dLnfWnU3J9s2n6abU0bZOWlgpGsa5mwTVqozl3Hsb7BqZ5iRYuB4whkI7KKbYMHrD9OAkMfdLQPi/t3t1WKhf5EB4C4tk/JhqKmTajpnFacLX58e0NPJlqvJtEzVGosqucvA6pOBDlq//4clk9PnxxtUH8qRjiAZRgyJcbKMHV3cAvhNO2jexe3ZTKbZ+pbWZ8joM9qbipCyqHlC7q/bel+xeZujKIAI5R1Ld4YWFJ0oTcOUTI/Z9d/357ZL0pAkK1PKqwEAmkG1wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WD9abJob; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WD9abJob;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYZbG11N8z2yYq
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 18:42:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E541CA405AE;
	Thu, 16 Jan 2025 07:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432DDC4CED6;
	Thu, 16 Jan 2025 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737013366;
	bh=lRWjx8TTBq3j1b0dqYw6XU1Qf2hUI2cm6gKE/V+ksXc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WD9abJobS93VRFIUEp/HKe/p4V+/x2M5KXMcJuFfb7VlAdvg564Z1DpSKNSDUnjkz
	 vMM8XJDh+FRRKxp3osIQpw2vooqp26w3x5fQDEfe+SQ6Qcwol/yM/VyoXaZWtQXvam
	 mcSQPXyOrqVNijlBgAGBNvN6WALCbPpCUZ6x+2ABQmlJmh+2+UOkd0CaN60U/sH1ef
	 bUF0iL0tgITOAH31+MaXX5v1R4mQf9n3zR9HS7iBAwSYwHNfsh10TaSyDpfkGGSDp2
	 jmMCqBUjgXmcobbpx7XwdEjIeytSjNsH3IbJnY5S+R1HLWIdBYgOmKc2rtrAak/J4X
	 2XEDcEahS7APQ==
Message-ID: <d042624b-5c65-451f-b6b5-c84e793e472f@kernel.org>
Date: Thu, 16 Jan 2025 15:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: erofs: xattr.c change kzalloc to kcalloc
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Ethan Carter Edwards <ethan@ethancedwards.com>,
 "xiang@kernel.org" <xiang@kernel.org>
References: <i3CLJhMELKzBJr3DaRyv-hP_4m-3Twx0sgBWXW6naZlMtHrIeWr93xOFshX8qZHDrJeSjHMTiUOh8JmBZ9v0AB-S1lIYM_d-vasSRlsF_s4=@ethancedwards.com>
 <80a3e6ab-839e-47b6-9554-fbaf330ab4b8@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <80a3e6ab-839e-47b6-9554-fbaf330ab4b8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 12/23/24 11:32, Gao Xiang wrote:
> On 2024/12/23 11:00, Ethan Carter Edwards wrote:
>>  From 272d7ef4611e64269fada0ea3021eece590118b9 Mon Sep 17 00:00:00 2001
>> From: Ethan Carter Edwards <ethan@ethancedwards.com>
>> Date: Sun, 22 Dec 2024 21:23:56 -0500
>> Subject: [PATCH] fs: erofs: xattr.c change kzalloc to kcalloc
>>
>> Refactor xattr.c to use kcalloc instead of kzalloc when multiplying
>> allocation size by count. This refactor prevents unintentional
>> memory overflows. Discovered by checkpatch.pl.
>>
>> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
