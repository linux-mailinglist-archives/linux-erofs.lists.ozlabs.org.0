Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D59BFCB9
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 03:46:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730947610;
	bh=ccKDXWFiIiah9JGBN8hDWmb3gmpH0/EN8xwZ0TH2sVE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jg2LspFplJNf/oGtnpsK5PqZDjUbc2LKN6BTSMhd9FSYLQ6hR+G7/cFkp7lqF7xA+
	 Kn5DvQRVw56CZBdTC5R2bP2oXGVmujwshXJXhjjFUeLTM/Kvzp7nxUeAkE9QImT5G3
	 ZlFiOxONFmRn3+WHvPoeILveMAvSOtPE3W2gfu/jE5D/zErhTaZqYilNTcpLPBiQPM
	 ruA1z8uF4H2kAHWIOBPI2ZNqtnOETPodStnDZL0kBh+aZuYZEyvNgj64lMwJN5O/OH
	 2gurktabr50ndGjtHB79h1B8opfLgI8X3jNJdZQWq2XXt26UdzEXWgyD3EEgA5Fg2l
	 Jz7TyPSs55RNA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkRL22MvDz3bjt
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 13:46:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730947607;
	cv=none; b=ebAGz3cNSZYLs3V48lxVIpliELa0RlcTK6mmIFZBVOmAbOCZUa65RjNrFRlSygrNlwWkHsspfU78+Py2AYLAWNKtT72D+prQAjqcq/WebEaK94Zjhqi/YdzlqehFgrsjI9lTMA3x1VUDF6X1ekEDKnUw5gXnbrx5l2XuuepsSudyBs7L/Ld5RTHqgrZSVOHEkWOp4kle6hz3G7vdYWcJymtPOKIJVvRBc/ylBMx/S+ta55K3/STDlq0YDHXbzsKv//mJfGBSoEXKuJ9EWfUu8MjD27QWdc9oVQnGE4lfGQG+H9eFx4ZrQzfO5U+TkJB+Rs58hBZD2J8lBuvlgo+log==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730947607; c=relaxed/relaxed;
	bh=ccKDXWFiIiah9JGBN8hDWmb3gmpH0/EN8xwZ0TH2sVE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E36OSfqxeQFM64npNpbR4oGTE0iprIasHmJegGs9vVH5grZJXfACoQNm2lfwUaQFHJ4FZ2WHwV7SK0YmM7869HyiyiB6OYan5Nj5EKcS4BHb0M8JwQjlKs5aNyBO3EUUH9EBR6//XkTN4wIZvvetunQ3daGrYuLoDiqaYjH4Gb2ZN7gswvTWviRiMumEXe6e8yvtCyL/Le0cHtDxZz+RA3S576gxxcjipSgCZfPqAbycekfhFxdiPPMQT0hGPcg52xlsIIvY9FVWYQ/MM0IVizD+ssgHEp2dXIjynHUlb700N3wtIhoCeQSSlveM69O8CEGXsEqM2TSdxo/UFfWZrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gbLpMboC; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gbLpMboC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkRKx70pZz2yVD
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 13:46:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DCA9E5C4707;
	Thu,  7 Nov 2024 02:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E1C4CEC6;
	Thu,  7 Nov 2024 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730947603;
	bh=sOfLVR7/GFSxqbczXVx6RK558SO0WB/sj2YsAvwQBwQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gbLpMboCRzojYnjesVu8OggNdt1imzzUI7HgmoGAZ9gxwlcWucXnT2XqpLnyzmKZ9
	 O0NZFOhw1SdNaXxccL8y+18Ya4CUwpAVFRU+soQZo9xfCvtzYgSGq0ySF5/rTCPFTy
	 2FZjpb68lAb2wuiIwjzkesHyRo4e4Vl5MRFp+z9r6/5tNl2bJLtKI773y+jl5deoi1
	 NfiY0izTPIXxzd3IVB301IIq/XutcVtjsllUka3vDDYymAvxG/iqYKnaykaK4+LbDQ
	 zZVXD117F0V+NP99fheCRA7bpLNQvzqYpbFXIxZqw0Az69zZEvJ9pitTHUElwdPbIl
	 CLBYz+TFpAUBQ==
Message-ID: <60df5036-7db0-426c-b942-d2393d4e5183@kernel.org>
Date: Thu, 7 Nov 2024 10:46:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add SEEK_{DATA,HOLE} support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241011065128.2097377-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241011065128.2097377-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

On 2024/10/11 14:51, Gao Xiang wrote:
> Many userspace programs (including erofs-utils itself) uses SEEK_DATA /
> SEEK_HOLE to parse hole extents in addition to FIEMAP.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
