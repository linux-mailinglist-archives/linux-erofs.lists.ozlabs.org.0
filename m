Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799826E3981
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:48:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PztMv25xtz3c73
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:48:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E7mi3uxa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E7mi3uxa;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PztMs0KS4z3c73
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:48:08 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAB661135;
	Sun, 16 Apr 2023 14:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C872C433EF;
	Sun, 16 Apr 2023 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681656486;
	bh=+a0833Q022asSsDMFXAzTB8hOzegGJrKUuEGygnRVOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7mi3uxamx51WL7jH5aOoWId6S8tVaFR4R82qhfdZIVRa9mOpdeu4s7Ku+s4X65Rz
	 /HhEbU2rd0PCFid0ZaO6lGdSpv0/2Qt4Bg2ek85/I+ja5DtkT+GPZZrpAfGaDa0nY4
	 MLBbjDIfTOS6OI39y91ZFb03AP98dEII5a0jca3wEgUEQE/I3hq6ItohhA1glfvxic
	 KFTwDrIO+Yid6zI4XY0q+J9KYsW24YBNyYcSmAoTY72eIDqxmtN100xxaBYZZ0HChs
	 Ahr/hzuIP0FXncM08eNyEHjtwN5MZI6sZmlHGLIBdbFU50GTXpCsBQRJCBKUQ1zXMe
	 FbOR6+BK/WcBQ==
Message-ID: <c2eb3d74-27be-bcbe-b83c-66fb4919c876@kernel.org>
Date: Sun, 16 Apr 2023 22:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] erofs: sunset erofs_dbg()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/4/14 16:30, Gao Xiang wrote:
> Such debug messages are rarely used now.  Let's get rid of these,
> and revert locally if they are needed for debugging.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
