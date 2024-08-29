Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E79644AC
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 14:36:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wvgkx3NcHz2yy9
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 22:36:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724934999;
	cv=none; b=PhbEi4i2Lso4px8bMSXbNev8eCaB6DRShVcdHFYF6yIszNQIAT4uI3s87emv9gySRZ6YaXij5WBK4E6KrUaMnW5AUBRVcyD9v3iMiT7DAZpqP5NpVHK87Cl9Vau3h1Q1I/tem8kO/AfvAkq2sxZh6bUcW8O1Hajhv7c7qh439rE4dJlL2wIW3WUqPtlPWSS1b2TaEq1RMDzm/0DLuaUSumJXZVRO0xMWafqrXvswEEFjRNG7LOz+9Zu20v8bPK+m8oU0Z+R57srOYVC0fkOkO+FJ7KjXpZoIxlfw0WDOT3lcLKfgVpmBeuVjY8vuJPrunv05W4iLFUjKtgX5djb20w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724934999; c=relaxed/relaxed;
	bh=VINzfzPx21qCy+WyvNibHQxd8FKqrqu0GcqrQzlXHUU=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=oULVPc/MziBrLfTEC3mqBZpECl+f6xYznoqEB9+6Jk0stlOldlhmoy42vv1li/wFOt6Tnr1oc+HktlJ+LDwsS8lgXCSqvDijqk3Ef/PblIMFTY8JN43iLZuu8xHZJiha9u0kDuigmY2qz4XznSuUaVr+4IcLXqG2uyGwFXbufXvJoDn/jLLD7BrH7VqkgeHqBqDPRLqTtOcHp2D68/5LupMLDmGPoUk47sjbzCvCD0NDyA9+fWGrk4VtCQo5tnK329U9Ew5leKjuwv4ImgGMDLQy+a3EkEgE253IY1s+eplZozew93qZ8CDsr5nCGfC6RPaOdzaWiTbd2uExVLNEEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kdM3EkFu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kdM3EkFu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wvgks6Kpqz2yvs
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 22:36:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724934991; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VINzfzPx21qCy+WyvNibHQxd8FKqrqu0GcqrQzlXHUU=;
	b=kdM3EkFu2AwAhRH/oVdgGDu2QfD7Tjme3vq65uqf2Dc3f4sFk1lxzt7sK6AP1a9FvM+7Uxk/gqGHsGOaqmtQLBfUF14hKCYwOfbHT5MUB+4Ij4NVNVjfPG/eAIqO8jN7KFXRPVhcPPVoM4JmsyMXALkBUHatcG/tFzo415p+VQI=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDt5UoR_1724934989)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 20:36:31 +0800
Message-ID: <7708e958-b9d5-40dc-8a40-2144f8e3a906@linux.alibaba.com>
Date: Thu, 29 Aug 2024 20:36:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: Prevent entering an infinite loop when i is 0
To: liujinbao1 <jinbaoliu365@gmail.com>, xiang@kernel.org
References: <20240829122342.309611-1-jinbaoliu365@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240829122342.309611-1-jinbaoliu365@gmail.com>
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
Cc: mazhenhua@xiaomi.com, linux-erofs@lists.ozlabs.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/29 20:23, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When i=0 and err is not equal to 0,
> the while(-1) loop will enter into an
> infinite loop. This patch avoids this issue
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Thanks for the patch:

Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
