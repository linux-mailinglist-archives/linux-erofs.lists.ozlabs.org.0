Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26A6B15F
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 23:50:39 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pDbc2RWwzDqX2
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 07:50:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="HoHXWOHW"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pDbX1RsdzDqQH
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 07:50:30 +1000 (AEST)
Received: from localhost (unknown [113.157.217.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21C7B206C2;
 Tue, 16 Jul 2019 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563313828;
 bh=G0Z3+W5+zm4O3AXRhymJcQTu/MjNvBgYP41CWsNye3U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HoHXWOHW/zh+IdYaM/4vfsRzwoOyMKXQA/J8h3OxGqc5zOSkZMuiJ63LAla243XMY
 0jV3VaWbvH0XJ+wrc6Ass0SbW4OQqfzVjlQ2FDRm/1FwQEPxq9uB4C+1AH/BV6hobB
 FqkaBtOopPsgsMlNCtplJXiOqb4GHvNAQsw83YY8=
Date: Wed, 17 Jul 2019 06:50:26 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Karen Palacio <karen.palacio.1994@gmail.com>
Subject: Re: [PATCH] v2: staging: erofs: fix typo
Message-ID: <20190716215026.GA18144@kroah.com>
References: <1563311783-12754-1-git-send-email-karen.palacio.1994@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563311783-12754-1-git-send-email-karen.palacio.1994@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org, yucha0@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 16, 2019 at 06:16:23PM -0300, Karen Palacio wrote:
> Fix typo in Kconfig
> Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>

I need a blank line before the signed-off-by line :(

3rd try?
