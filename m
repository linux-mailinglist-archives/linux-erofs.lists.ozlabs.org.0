Return-Path: <linux-erofs+bounces-1819-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172BFD116A8
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 10:10:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqRS15ZjHz2yyy;
	Mon, 12 Jan 2026 20:10:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768209041;
	cv=none; b=PkVbDxGou5+YeU0PBoNjjStwpmfq3NuyYX9NFCG6nVWxPTg9SYp0Q3tceLCE/XR9AnMfIPnLEcgETgiuyGnJH7VhraPmEnsX75Ko0Yc9fZGQ3kQGbUwEcfN1HN1Td6BaaiQ1nTvIPrb6LsTxT0VjPRoxPSZvzjFYNUkqTM0xOjX3a7/BKfov5uQ4h1YfETjisf8xsB4zk8+CPPRyOHcC7CkyELKtUT0fPhrGq5ZJNNW4XQER7iyq/ZVG+1Dx7vvFeVkvaAtvr8xuVqDFzBda6AbAINHswtwYd3uaG5orcoF2AHHHKKf/L5rAY2JOtYKC74oy7H6jRgruk8OUEWOjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768209041; c=relaxed/relaxed;
	bh=JilZEH6UQS80yUBNcyjv1x+NvSKcdeybvSlfCPlRUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHSaNXsUPabJdm6GIxsRz1lTstByDBGKcHfaGal1FoasUN8mgycj2IYFE/z/+CIigDra0KZMyXz9uu4mSJX3zonRtdFafIDn/JahzYWPVwYk4PgvDB05tH05g0GS+XxBK8K6UKCAHhzHHCDEwY1mWpqAFBRIw6IH8Jvl62ZQoAOQmKb2u5WB9Gy0YyBHGxoei3pXYIMjZQ11k7XxAnI4/1s+xoutZoDc/WnD5Ieu+hL1FHZoS0wngjjKVDGmb+4/CX4P13V/+iNXpe0/LVC02KmFTScXCpfirHVaeW+6rpheC9AM8UDJBgPsXhW06ScPMsQGTLQUgH0viwm6NNcNGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZbzVYqFP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZbzVYqFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqRS059jHz2yxk
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 20:10:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F25B42A2A;
	Mon, 12 Jan 2026 09:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B75CC116D0;
	Mon, 12 Jan 2026 09:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209038;
	bh=anQHeyKqkGvMtUYSA1DooDkEFH3wVejNmY4OIw3NEhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbzVYqFPzcix9RRop5g1a3lPwK0RW1lo5Hk2qugRk2dqccUER0hbhTfxfav4u4KUJ
	 vhT1zdaeCazrYVMeNO9oWNmJJ61DCD/lC6W+sLQCZrd2tWowNxFVLN99KKvyOTbRiM
	 4ThZaKaZKELNKz1FsvjoMDbqZzfQwB7jLqKT57Z3e71GyWb9xqlSfBboVKSL8XZ6VF
	 CSK+yn7xKdb5nx7HvkYbTqa1B/5u0X9J/ovHRxJB7HGchFBTdDMjsYgw3yiQT4Hdgm
	 8sKOMJY2G9WJqRuaR5NRLWploez8ETzLoeVrCeSeXcAVq7otgI56REKuMglpF9YvYP
	 fjgpxJa33C0BQ==
Date: Mon, 12 Jan 2026 10:10:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, djwong@kernel.org, 
	amir73il@gmail.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 03/10] fs: Export alloc_empty_backing_file
Message-ID: <20260112-renitent-mitbringen-e94874417a07@brauner>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-4-lihongbo22@huawei.com>
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
In-Reply-To: <20260109102856.598531-4-lihongbo22@huawei.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 09, 2026 at 10:28:49AM +0000, Hongbo Li wrote:
> There is no need to open nonexistent real files if backing files
> couldn't be backed by real files (e.g., EROFS page cache sharing
> doesn't need typical real files to open again).
> 
> Therefore, we export the alloc_empty_backing_file() helper, allowing
> filesystems to dynamically set the backing file without real file
> open. This is particularly useful for obtaining the correct @path
> and @inode when calling file_user_path() and file_user_inode().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

