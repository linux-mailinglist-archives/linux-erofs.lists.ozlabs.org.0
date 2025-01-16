Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA3A13833
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 11:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737024308;
	bh=yG8E35YKtO+sHw/tCNifhUMFyNga3so200DDDcN8MDw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TDnAjgXKkWPoBH/j7YBbruaq95xcvFrj9R2W+eYcTQMUixg/zmZoKpSCrVA/aH5tQ
	 aXL33E9Ve6kxOWFK8C+xV/Hg4/q0YWnES8c+hmcFegTPZfa+SMBmZdMKLuFPpy6f2y
	 6rJYCEkbu++4JO99kNJgdsqQcfngmxM2bNTpyXmYu/dp5AianzR14Eqq5ALQ0JbCE0
	 rTKCiI2+hhbSnd+RZFyjWlRDzvizSWTq4Z74GMtRxDcdYhOQ1uU6xJAMpNj9OuwoVJ
	 GAGAtkn+Sg9Tsp/KCThYQHNV8s026fXXQtUOF0bJBKPRAzzvvk1pGstjAYRvkdSfcr
	 Xe0bzgOnR6eHA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYfdc3nqpz3cfy
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 21:45:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737024306;
	cv=none; b=BST4t6yusJLVUHirUsIaniydurxK2qrfzbN2cVgxYyCM2/yH3sQqsCOQ2ymS60CHvmApekCtfegMlSKnK6FMwZUNDl04CkTjnmgKu6xtJzVM2xf/OEamhO5ABvvanE9UUEK6QztbsZOfGlYxKQDVFH7zs4/RwBy1tQye7JC6xKRUXJ+Hz+mKPSlYLP4Ll7lDp5wescaeJtDqr71jAYQAi3ZmvRh4ZkTFKrYOh/u9wEpmVfb6OnxUohZZmtnEH2JQdz9wE+wMmQyL68zpzURPr7FXf3P0UvUA9/3BJFseu+s+QKqckVhq9nJZ7P5rPqerm/axD9Em5oxGvgFni65vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737024306; c=relaxed/relaxed;
	bh=yG8E35YKtO+sHw/tCNifhUMFyNga3so200DDDcN8MDw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hznZPgHPMwlQI+M4ggJou2AVW/ZA/T2j/ZcSILIv5CWitr9DJaSmWJaWQEg91cDNbm13BrFGG3k11dKYC/sAOBSJbD0obVuNZTIM0cykK+CHgoftm/p02qW0snXg/MnQGtOhqGneCeY/EpFcar4tfCBW+jECLIZ8Ljn6Fv/qSWXBfwbG35oJsJd/CX7BKLp6fWQ5VwIAmGZmtwJjN1+dr/cl4Eo2CHP1wVJwVYQzwqyWZjZ0fod03MonjoP82KL9qnJ3rXuweIpjCoy+Z+xaceFH+bAKOXaxh3KzUGtRb9VcD+QuvxlTLJbHrywSk72lS/TIvQnYiGUu7aypXASAtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N4qdmwm3; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N4qdmwm3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYfdY6bLBz3cYy
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 21:45:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 45B04A415DA;
	Thu, 16 Jan 2025 10:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14F0C4CED6;
	Thu, 16 Jan 2025 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737024301;
	bh=Gp48iWFwusEaotP7NzEFfW60R1/q2fKwzRknJ8PHFcg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N4qdmwm3tb9Gz9kg2Mt+9E963cWh+Hx0K6HkhJY3K0kRPMRyVzbtZCRdPIpg/m3bs
	 LSO6L+moixmkklzWBWKadaONlwp6M3c3z3fNsvUYcWo7jmh4K67MvyR43BiIw4KLsC
	 /u3Jxu8wTSsDnjrCQFb4GzGU+/loqbv+Dap1AB3GgzRDxG2s+Azdj66q8zsdMapU3U
	 Zef5hO/7aU0HDroDEGceIVoGorcFHbLyOWpYhGNBWCn0y1X+VaCB+SBe6MHvjO44r0
	 zgJvgJx4V70ZcHSmlx5Y4oXu5if2AQ+rPoII7A7bHr3Qs5BTlHFSxHEJj3pLMNRFq0
	 AIdfR1tr2qFSA==
Message-ID: <30280de0-a0d7-40f4-b547-131caaca2efe@kernel.org>
Date: Thu, 16 Jan 2025 18:44:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] erofs: tidy up zdata.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
 <20250114034429.431408-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250114034429.431408-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 1/14/25 11:44, Gao Xiang wrote:
> All small code style adjustments, no logic changes:
> 
>   - z_erofs_decompress_frontend => z_erofs_frontend;
>   - z_erofs_decompress_backend => z_erofs_backend;
>   - Use Z_EROFS_DEFINE_FRONTEND() to replace DECOMPRESS_FRONTEND_INIT();
>   - `nr_folios` should be `nrpages` in z_erofs_readahead();
>   - Refine in-line comments.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
