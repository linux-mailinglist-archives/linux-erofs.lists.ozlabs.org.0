Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95EE74F0D6
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 15:56:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cvytjGdv;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0j8g4J7Dz3bbW
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 23:56:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cvytjGdv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0j8c3KcLz30PL
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 23:56:32 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6C862614F9;
	Tue, 11 Jul 2023 13:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58008C433C8;
	Tue, 11 Jul 2023 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689083789;
	bh=qXZaYifrGUQeoLHM3DrN40jfqkcENYlJOULXTr7bL58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cvytjGdvzrWapWKJcPPm6KysqJl/k0pfkT+QBiYVsuAFaYSx/WXQVyHNHwa1Yn8K9
	 3Fje5S9+D9qILv/6gqEu8AcOxZArpJXIsdYUIuPBIVGhJj/DMQyYR1XKzUjQU88zyb
	 vDUK2iskiVWVVEPohO5VR0Fzo0LrcSlquH5mjTu0GJOqaMfPkbk0YbJmp2b2qcp2Ac
	 VnkEdLXDlV4JCrFuRa7xEHV26JDvy30mlCFCR1YvgvFoKk9gRwvAzAs/g5b4USTfay
	 fY2YxsixmG1n7DvDJOp9zHGzyv+BEnhSfeFpRLWaebPX9qE5TZSfCqYZA92V/LE1lq
	 PEsbHOaDjsasQ==
Message-ID: <56c3e00b-d383-105d-29a3-570d94df4801@kernel.org>
Date: Tue, 11 Jul 2023 21:56:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: avoid unnecessary loops in
 z_erofs_pcluster_readmore() when read page beyond EOF
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20230710042531.28761-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230710042531.28761-1-guochunhai@vivo.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/7/10 12:25, Chunhai Guo wrote:
> z_erofs_pcluster_readmore() may take a long time to loop when the page
> offset is large enough, which is unnecessary should be prevented.
> For example, when the following case is encountered, it will loop 4691368
> times, taking about 27 seconds.
>      - offset = 19217289215
>      - inode_size = 1442672
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
