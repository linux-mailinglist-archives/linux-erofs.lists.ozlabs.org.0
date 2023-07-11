Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C064E74F159
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 16:13:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EciwUIRW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0jWw4kQvz3bdG
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 00:13:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EciwUIRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0jWs6Xgvz30g1
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 00:13:13 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DBA1D61360;
	Tue, 11 Jul 2023 14:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A383C433C7;
	Tue, 11 Jul 2023 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689084791;
	bh=ey4qn+pT0IA1mK/T0+mJ6fLdRbp//RxtgG7x1mdoLLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EciwUIRWaebB86Qom7c2/r8nP+TILoFVFBdaKK6DYkhMRyCA8COYXi7ESsPZ6Gs5g
	 O/igAFHMLW30AQAvyNH1IRHYHZZ71sLeUCmiHwtveXv9iVhaLzeeh55Q/Bv2LZ4Wj0
	 CICwMo4kyjDBC2xmrw/dwoOyMcLRqU6sUWlnlymtOBwoNjDB9e0VBADysTMLsExYvH
	 Jqb/turISJkZhLq/2hjcwzwZcQe9PPO/D6ZgcQ29/Tl4b0Yzag/n/lXxt7orIVRsLV
	 RlkQ3L4JQHzOPPWfkEUTcMNy9RodN62f99g9mrA7wXDkwjrILI9YXCSH1btkIv2BOw
	 8S1uGbN9Tptug==
Message-ID: <b80ed611-7844-5cb8-255e-b41e78901942@kernel.org>
Date: Tue, 11 Jul 2023 22:13:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: fix to avoid infinite loop in
 z_erofs_do_read_page() when read page beyond EOF
Content-Language: en-US
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20230710093410.44071-1-guochunhai@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230710093410.44071-1-guochunhai@vivo.com>
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

On 2023/7/10 17:34, Chunhai Guo wrote:
> z_erofs_do_read_page() may loop infinitely due to the inappropriate
> truncation in the below statement. Since the offset is 64 bits and min_t()
> truncates the result to 32 bits. The solution is to replace unsigned int
> with a 64-bit type, such as erofs_off_t.
>      cur = end - min_t(unsigned int, offset + end - map->m_la, end);
> 
>      - For example:
>          - offset = 0x400160000
>          - end = 0x370
>          - map->m_la = 0x160370
>          - offset + end - map->m_la = 0x400000000
>          - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>      - Expected result:
>          - cur = 0
>      - Actual result:
>          - cur = 0x370
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
