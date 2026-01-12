Return-Path: <linux-erofs+bounces-1820-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EBD116F3
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 10:14:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqRXp3rD1z301X;
	Mon, 12 Jan 2026 20:14:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768209290;
	cv=none; b=d+qZbwtg8DIVnHaXwi4eandd4Ps6znAf2Hupz6usFMENjWLOQ8TN1in0QIS7X+2orlJfGZvIQAzSRdRQmHgGwYwrCew+HcSYfuxx1AHwsGA+byliLXRM5wgVCU1pzkgrul4EhP1TwAKC/n+D/I//4YB3Wecju7lUgfsMg0jwzInBPwtUV4liLTSY0eFTAH3hF2G9GtaQHL6NtetpJRa2Lw954Dt+uxdVEpMEc3Hu95MqQ42PkNB1bWaG2ptXgUFysfVojosrcE8gKRO81vzQ/MPP0B69e3rGmcn3X6tTzeX3259Z3z1jwxKc8JuyCXcuhwNsgXEGk+X6bHpUBWUnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768209290; c=relaxed/relaxed;
	bh=El49wXngCxcDbS2huc5sjL1mwHbwLCRB8Y6q80OKsSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fATkLwzpquLKwh2ab8Fd2Ju06ILPZ1P3Rk+IlKYoxPZXEmKLUA4aq65V8V6TJaXbM9OY81vZreEAZGP3fv7Re3RN/7WxeNf9qjR2SXMoFgrj7UBG+zEJvz23hCIuQV2jniKGNTyAK4/ybEs4TjjRFIsn7dELKPt/f3d0m4AR6WXQS16XzSNqNcsLdWEgPNhpeQNEQ6JqMmXzNtPOKk/VCUrcV+hwrPgtNYwTZRl4BuLB1W+UvNGx+7AHGuFJs9YczJE8NvgvLHsDhOR7oMQX2serrO2aC60d/azF4iaYxBVL3rDggYZd6FP4Y6zfF2Zhqu01FOmrqmc4mZqOVeUjvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h8Tm0BOe; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h8Tm0BOe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqRXn74jMz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 20:14:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F8A041E43;
	Mon, 12 Jan 2026 09:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F5C16AAE;
	Mon, 12 Jan 2026 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209258;
	bh=El49wXngCxcDbS2huc5sjL1mwHbwLCRB8Y6q80OKsSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8Tm0BOeJqBE3hppZd7gxOZWFXZ4XCv1Sr0iIxwDPxhJH3P42DdqLGuXWl95Ur5i1
	 wdIylCGI27w5e0wio9DZKETB6KHH1rhZCsMAWjAhqKQo+Eea0dMQvkrMwrscD6Gz/Z
	 mZWJJ1nYT40fDNqbU3T4bSHXzpi6FHuVbS3zN4nu+shuuAuWPVYhpY0mJAUPxKCDFw
	 QiWJOkq/nM/fqQP2hd0aogvbaMNeiQWQf2vPGny5pQqr7dwWNvA9s+N2nekhfLwhpd
	 ALrBl9wP0ezaTdINwdE4p86hki6gjakryn3aBVdSXAWAqVWz7drKmhVKx3ENLa/760
	 PVSXUML+OfCZQ==
Date: Mon, 12 Jan 2026 10:14:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, djwong@kernel.org, 
	amir73il@gmail.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
Message-ID: <20260112-begreifbar-hasten-da396ac2759b@brauner>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109102856.598531-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
> Enabling page cahe sharing in container scenarios has become increasingly
> crucial, as it can significantly reduce memory usage. In previous efforts,
> Hongzhen has done substantial work to push this feature into the EROFS
> mainline. Due to other commitments, he hasn't been able to continue his
> work recently, and I'm very pleased to build upon his work and continue
> to refine this implementation.

I can't vouch for implementation details but I like the idea so +1 from me.

