Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA8433671
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 14:57:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYYfk4lyXz304v
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 23:57:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SkAI15oe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SkAI15oe; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYYfc4sWZz2yWG
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Oct 2021 23:56:56 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED4461360;
 Tue, 19 Oct 2021 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634648213;
 bh=rpzdWCUEobf/IDekmzPNEYMxSWhS5XWJoeBbvCLEQ2U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SkAI15oe3aJqLCpSAzrO1oNSzlppscoCUOiUzA7fi5zu5mUJQpLt+Sa3RWydsPguM
 dsNBiEP7+oW61RI4tzrMR0HfkwfNwH86kvNPsO+0v4pgkPLrX4itZVmg05Usljt3CS
 aTh0bKM+noFjYEpCyQEa9/GI6ANXD4XEXQ+JhJktuCUAJW8iNONdW7o4trS39Fnkc2
 vI5I9/+PAnkXymgQYL0ovGmzFysbOBVTavIqa+3EwcKrMQ3ZINlXokDxm0mEv2klK6
 xEpCCOLbDPkh3fonvx/HGEzuARRjoZIT5bPtjEbc+vyLnYBZNAmcx0/NJChmnE0zDp
 WTjbJoHioE+3A==
Message-ID: <bec868c6-02c3-5f6d-c5d4-84cb4e1c9cb1@kernel.org>
Date: Tue, 19 Oct 2021 20:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/3] erofs: introduce the secondary compression head
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20211009181209.23041-1-xiang@kernel.org>
 <20211017165721.2442-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211017165721.2442-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/18 0:57, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
> lcluster to indicate whether the whole pcluster is compressed or not.
> 
> In this patch, a new HEAD2 head type is introduced to specify another
> compression algorithm other than the primary algorithm for each
> compressed file, which can be used for upcoming LZMA compression and
> LZ4 range dictionary compression for various data patterns.
> 
> It has been stayed in the EROFS roadmap for years. Complete it now!
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
