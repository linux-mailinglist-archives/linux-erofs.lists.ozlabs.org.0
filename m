Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69B366771
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Apr 2021 11:01:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQDzt2QGzz2yxV
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Apr 2021 19:00:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gK+a5JK2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gK+a5JK2; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQDzq3DFPz2xg6
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Apr 2021 19:00:55 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E56461427;
 Wed, 21 Apr 2021 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618995652;
 bh=Jx01SeS01P1GLWyzGDRTgEFpK6qSsOb1ejgSUqdXi18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gK+a5JK2JObP5Fbr/6/YcnIEDjSH/2A2uN357Myp7kDh83wr/GPT0ZxnPsNjyWZQA
 tfwPKRjf1IROSFcmiaGP0gLXvwXwSPSB9H4t2Ik7esPEYNNpHjUsd1lL9FvPJFCU7C
 6VTjYCqeHp/t1h5dbta5YegLvrOBjd+SPAtTiNPVB9o7p4WLfBbJ6v3ZbIs+lQE4LS
 90S7vIqrdPJtjMUN+bcfsfgrNB02fVlXaL64u2bHWUmiZMNQ842ClAPmT1sneuuQIy
 /IXIE9yxiJwKZLCXTzuJvYEfDWltkrQQOXt2jAO/TIQxmaoHlFbB39OFUFTan5em5z
 gFzMqWq4JuExg==
Date: Wed, 21 Apr 2021 17:00:32 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: remove duplicate __func__ print
Message-ID: <20210421090031.GA27889@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210420115237.52938-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420115237.52938-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 20, 2021 at 07:52:37PM +0800, Huang Jianan via Linux-erofs wrote:
> __func__ has been printed in the macro definition of erofs_err.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
