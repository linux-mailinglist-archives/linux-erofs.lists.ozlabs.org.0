Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA99970C6D
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 05:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725853391;
	bh=B3duh6Lgl0ZBEXZ5iPOKj6QG5eosGqX9GL2XCT5b6WQ=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SaVWiYLAoZfyPGkuWBkR2SQf1r+ZetCvAusM1aYYvVcDe6ZGPacel1AW2JLIxyup/
	 qTf01PnOAxJA5IDEx5UrzJ3ZMdX8kVUbl9dlUrJDEXTZrHf5zQX+c7t1boF3eGOrRy
	 RS4uwQmuebRqLo/5V/nUoymvox/zVC3VPeHwn2d8Ub9+6cMwMFwYzRMXBqWoB0JCnk
	 T3TCbqokPkYVjmYPSxPrdOT1bzA2DrLSvrMLN/pf+r+WRPzEzXhxqjfh81PofDdTNy
	 9TVp5wpHEo4TikPzL8txreeSX2K1aC3/8Gwwx7G17Q6m+Yx6mug1ZvunJtc5219b/0
	 xGhh7Oje99q8A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2CNH0G90z2yLC
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 13:43:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725853388;
	cv=none; b=dLVexrE+Fu1F9JCMAxSpRqStfaS7kRBYnyA3qT1p8nQaXIfgcZbWUJjCoIO7tHTVZ1d2b/5yTvifZivFfrUVvaJy+Ao6VVvlBD3Y1jJg6aWeTz8RNPij7LYrh+2lHQHdGnC86DqQD73Su8Jtrn8L8JYlMJhYIygKvwbY0KJQvSWeEGbqq3o3X5ZogUhLHpOcKsyWlQtZb1dZ+umr8synw3zLrtzA19LY64QAq1WN6g1P2zIUAiMIVNwMN7kCQ7bXxeFhe8rgEhwgerYL3FO1cZo5JPw3KaiPepy2xCi3FuTCqALJCRiD1/SweTodFuVBVDO5afqglSzczdtaHnNBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725853388; c=relaxed/relaxed;
	bh=B3duh6Lgl0ZBEXZ5iPOKj6QG5eosGqX9GL2XCT5b6WQ=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Cc:Subject:To:
	 References:From:In-Reply-To:Content-Type; b=V57A7Eg7WlzPrZuqHXDLSHzj5sgMtY9jG7gcdqDcukcLziIXVpWiYC0SdSDh91uqe4r+QOHiw48mIz1mESLPzSszQgQlDgBuosqAsHZoX7DJGSSsEAfWdWVmpbz3KrniGItzNirJiNiDvQ7V+el2AKVyzaM/yYZdQ3gSmQh4bm7p34r+xM0jpPsKEvJ0rIcPgSaq2TB174mjVn/DmRPY9OchLCzLraVNmHpNMRF83YsqkoVTEy9/M4Fd6rKbA9gro5FMpVN8QL5gRZ+xGfU7NOT9oAVGCtRLYYrDJuwKoRWrlYe2JY35kdnvF3wNM7MsJCBeMaow4j5M5IYZvzN3Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IqaRAVe9; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IqaRAVe9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2CND30x0z2xCp
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 13:43:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C9B78A41B30;
	Mon,  9 Sep 2024 03:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5758EC4CEC3;
	Mon,  9 Sep 2024 03:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853385;
	bh=XNyhXsq9g54lheOKab8l6FLqKbP79ACZqC8Y6P3P1Gg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IqaRAVe9IBUtbV8BCo8oT7PjTEK7RGN/mxwgQXf4QWeEOtW7mkDjI0CUrdpcwhRRR
	 NIQ7VtSCBdtA0qm2jkMO4liL+aOv5REsNjsQK5EXUjRk6o87nYDQPfK1HKcynkIs73
	 UrRvGjlkOmBvQ7QozK28R04f7A+BKgePBRBH09+5UVgITFb6zGdHSLZoNvGmJkO2cL
	 WA6x2UIrbHL68e1JKwuAQuL88RLsMAJ6Zm5Fx4oMco5kvnuqYdNkeNlxco+zHHI7MU
	 HS2rjJcYCOxoudgniEZ9cl+bEsfgTfHLIVgu0GbgrKrLJUhXUf5fo1o0LZHi6Xaure
	 ERav2hiHRurMA==
Message-ID: <87992941-33af-4bde-8ed7-3b24b66e7b1c@kernel.org>
Date: Mon, 9 Sep 2024 11:43:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify erofs_map_blocks_flatmode()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/5 11:03, Hongzhen Luo wrote:
> Get rid of redundant variables (nblocks, offset) and a dead branch
> (!tailendpacking).
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
