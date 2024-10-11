Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FB3999B03
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 05:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728616335;
	bh=sWCUGrFlf917GdtQEMJONfMzAgH5AP2rbJR92X44RMs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mtRLEQ07pnD+MjD2JnCOpxIooa0ikhPXpXynIfT1I6FbNHsrtFqPBnxIw9mEOyR2G
	 ieVk3jBe0KLuxkWD8JipkpD5LYGOoERBYjcZnQjaAE/qhSeKWej7gVolug8C05Xf5A
	 OU5z3sx+XsXDzT/iQCzqPlT+R86GitCuv8YVNZq2ouRjqCCWQzgP+HlYeOg7nnlqDq
	 tjf/qh8DyJI9Lh2GhvqqoM4+NoNQTBxihpbOl4G178NXJz815nmTiuurOBHiKwqWB6
	 sn3TVXt8E3rB8sqLxnzlKEPshVJyi3Akb5Pn0LhuAE1pJItVJqHTw4mM19WMkjuObt
	 daFzKgLSO0piw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPs9q0x0Dz3brL
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 14:12:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728616333;
	cv=none; b=cFfXDqt3at8vbqFsmzhaL0gDC042myZ8BFgDUO2YPR0XDYgnbLG81t3JsByzmltAkoHBeqTur4RGYzsti4opriueZh81Ok81BCxOtr7MBE9flSHsovLmfyhAAsHYCnd/LRG5nYj+PSoIY2YCGXSIy2+PnvERNajhU4zfI6nnEqFzpjINiLbjq86PUmWSpyOXl84o+fG2YHBcoRTvwTKZ3u29mp4Oq4NO5fc/1hAB29eXHi975c0pu4ZQFylwnADGPcVrHZPOAntXAuk6HBbYvCYeUxZiHbRAf8x9iR7jamTqQBo2Tlyz8hMf3iCTSZmupDhK9nZ0enU6Eie9+g/LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728616333; c=relaxed/relaxed;
	bh=sWCUGrFlf917GdtQEMJONfMzAgH5AP2rbJR92X44RMs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Il7cfrjNERaVTgSDlDqEaqWCHLPjcuXhD2Id6lBAEu6FL8ggGS1sDqoutI6U+FcvmBVyTQsQ7Z9Cq/3/9PS4ei9Ua5h3ivpdSYTZEFKqRErlr7pqi1Lf/Go3y6Aue9HWRPUb2+WuIW/B+agtjSVensUyNAlQw0YEbRB5BmAsSm4GFU7uFy0Z1j3ULrrhfdEIduheuOGjwRdbz1tnzBTY/7iae7+vg3Tu0498bu1SSS9W03K7Cuk0CugXScVKA6V/sCDJ396iBwL4zKuTI+3n6gOXsOBjdHQiuSG4ERSEtdUFkL32KwO2bSZcALN5FRzad3gWtJ3PXCwIZozgcEJIUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rrJL1zP0; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rrJL1zP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPs9m6DWJz3bcX
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 14:12:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3D4D3A44F1A;
	Fri, 11 Oct 2024 03:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CD2C4CEC5;
	Fri, 11 Oct 2024 03:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616329;
	bh=ES9TOK7eJS1nx2Q3UXzWLwz7JYFWeDakG2nX1hzty00=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rrJL1zP0JmkuA7xQA+fTj/43kqEf5OVPK2chcJL8g+hFtZa0c3b4EE32VrG1B2NhL
	 huIaj3WeYxbgB6YGyehUJVRoH+StXBNidAxHkPrEhi5Hgsd6KRTzv/OTgRIWWQkbHH
	 ub71sQTBrdjWVjRrW9u1/f7ukESgiN3Vke1iyeyaCtKPHhdGhrwbD8zLTWl6Q9kvQe
	 qb9mddzNuVIvoD2h5CPrj8waKRKhtsoU3G2O+FW8FQmPQvuZJmawZvH1FCxZFWbqq1
	 MSmeLobOxLGRBjcn9yq01z4vYNHxKQD4zpRv+RRx5waYcY/pUGKwNKyEnsZ+QM1wC7
	 Tu70JwVSbSAqA==
Message-ID: <76644f60-d310-490e-8924-aebff9ae6250@kernel.org>
Date: Fri, 11 Oct 2024 11:12:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: get rid of z_erofs_try_to_claim_pcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/10/10 17:04, Gao Xiang wrote:
> Just fold it into the caller for simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
