Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E284DC5BC
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 13:23:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KK5s30Qfyz30J7
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 23:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ljufRSOj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ljufRSOj; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KK5rx2tpjz30CP
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 23:23:13 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3991560EEF;
 Thu, 17 Mar 2022 12:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F41C340E9;
 Thu, 17 Mar 2022 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647519789;
 bh=FMgPDbk2fBw3oYvS8YviKVNhODsyO44hJ1OmNfCDISo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ljufRSOjhQHYhrd85n5Myho6xsI7ty90UxcG8IIg35ZYbqTwNq7D/RHnlMHI0hFM+
 ghHs0QzGgmVMKOq6W6sofOkx4acz600s26sfdrSOQU3+jvLAKPaN9JE2sIa0RTOqro
 V8tPCcNMqaEV+sDBLbkfwsD09N2p/xbKbzbYBbcU8ZExwuFjaeofgBLCEXz3WuvU5e
 GM45pFkzBNbhwebgobXZp9aVP+yQV6xfLrGJ9XggMzZnVTaBT+EUdd4mLnHjF5rf6X
 AnpcUAfAwYiek0NB4MXo8Hg9X21L2t8sZCANEGGhwUPk1fy56xXT2Ibj8pFVRQC8Rk
 qQJQqrptrZ8cw==
Message-ID: <40bafa49-41a0-880d-d1bc-85124cf9f750@kernel.org>
Date: Thu, 17 Mar 2022 20:23:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] erofs: rename ctime to mtime
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <YjFrSivX%2F%2F3sGdSr@B-P7TQMD6M-0146.local>
 <20220317114959.106787-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220317114959.106787-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/17 19:49, Gao Xiang wrote:
> From: David Anderson <dvander@google.com>
> 
> EROFS images should inherit modification time rather than change time,
> since users and host tooling have no easy way to control change time.
> 
> To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
> renamed to i_mtime and i_mtime_nsec.
> 
> Signed-off-by: David Anderson <dvander@google.com>
> [ Gao Xiang: update document as well. ]
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
