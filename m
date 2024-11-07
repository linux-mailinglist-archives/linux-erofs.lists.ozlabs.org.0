Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B170B9BFCE1
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 04:14:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730949296;
	bh=JpcWSGKFCEH9VxBrJ4iqWxkW61K2z4Y8noSwyj4VtJ8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Jqlv8SEKPXP8IyZ2fF3TU2D6XUf+yoUJeEcFj+N7tSUkWDS9M2qUXaO9tw4lw9K9L
	 TpUAFnWfLdZUw0Bfx/utg4bH6sdcoyzK4QW9T1nIS18NxEejwwBrOC1g1jbwRNmgE4
	 fJrfMQxBcswSw4NcT0DUmWUCJMSBB07VfdcXfYW1l9ey/KNWqhxXHK6j7uRtOsAKtH
	 rKXRcl4kHz8tdjsSVjg3EdovnZ4xtdceItjCnFqEra32lD4KyrHB1g2R+htfCOl6jv
	 +94iLxyJRaLvvrO4Q1rHfGbDMBqSZqFS6CUClSTnVB2HDaDgXaJ8L6o0Owawv+edq1
	 qJFB9LwIi4qaw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkRyS1FqJz3bkY
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 14:14:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730949294;
	cv=none; b=TA4vwPOp2QI3xHyRGoFJZCXFLJedUR2ml3EP5+ImGv+bvOSr36U7DyKrnp+lKY++27D8sp/TW40aSQ18WHp6LTd0cpP9fKKgAggukoLE7baM0lzEtdJwIdzw/5I9JHnN97YonOtlwvCTaD5LV3RmTYCs4QAhv7hComh0In3GGk3TjuzK8H7GVBQIR2XS1z7hEX8IDUpI+Heda3FoyliXNfA+q4ZLtj82L+bWCOSOr1tcLcAsAGRhmxpRblJzwKu56KM/QixQePeF3bEE28E5LgK7WaPdm9c+PP/Fnq3oR7grGcxOcAK1DfH4eeBGDK3jz3tyjVwJxpHaRlzWsEMxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730949294; c=relaxed/relaxed;
	bh=JpcWSGKFCEH9VxBrJ4iqWxkW61K2z4Y8noSwyj4VtJ8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GYkcDLDbL5zIG8XwuH2Vm8fsnyrx7csNB5tg4che0M86npYbZBJIOEGG+Xn/LqFAwG+VIFVrT9mnM+PiEZwEY7dPxskI09+lCEsJwEZ8Lzan3DCUeOQsdc6IxQsPEo9AyLYLOgLosCOFulLkDvouyBFsHa0G4lJndsz71WmbTqY21QS9+Im5DPp3wyqlMWWBL45pYUlMCHL6fFAmFDNaMWRsbL7Rse59xqvWndn1vXINnrQjFfxjea9KFRGRSk+l5fWf04ckFMCROKqB0PmjFR71I/7+5XfJAHcM/apElHHSf+457UYpgIzMI0fBekFPECXcJz1whOXy3CuKqKymlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sT9wTfya; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sT9wTfya;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkRyP5SpFz30PD
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 14:14:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DDF08A42147;
	Thu,  7 Nov 2024 03:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482AC4CED2;
	Thu,  7 Nov 2024 03:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730949290;
	bh=h0jFYPz6CEDXwqDNktCDvd0yTqHMMXs8qp/E77CUE2E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sT9wTfya+f08N+Ouj4jqm0BTMhXUFQrPlw7wDeonqbPdMOJSUjb3VjCnqfG4KcgcE
	 QLBk+kYqkY8EtogjCBPyvRdm2E/9MM9k/X16QoKIA/UKpu2R6ibQ9TGee+5TikovKm
	 F19wVahVeGOFQzc/L2GldPvPIMt/panDrHIA/48haPr6dqPDQNMSkS1Q2s8ncTEvXo
	 5SgyPwyUyFTkUg5QwUDtXQMbzB/4/6UgPfvcJ544z0M8EaFVq9YFF47UZjp5TXJiO1
	 GDapqm7Dcm3JmyP9EEwB3KXGaxLQmcaJRbO9HSkdMyJJAnMz0MJit2VUXeAtYjTcEp
	 6Xt/OOWhUaQyQ==
Message-ID: <c2fb74bb-99f9-40cb-91a2-08ef862a1d5b@kernel.org>
Date: Thu, 7 Nov 2024 11:14:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] erofs: move erofs_workgroup operations into
 zdata.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <20241021035323.3280682-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241021035323.3280682-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/10/21 11:53, Gao Xiang wrote:
> Move related helpers into zdata.c as an intermediate step of getting
> rid of `struct erofs_workgroup`, and rename:
> 
>   erofs_workgroup_put => z_erofs_put_pcluster
>   erofs_workgroup_get => z_erofs_get_pcluster
>   erofs_try_to_release_workgroup => erofs_try_to_release_pcluster
>   erofs_shrink_workstation => z_erofs_shrink_scan
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
