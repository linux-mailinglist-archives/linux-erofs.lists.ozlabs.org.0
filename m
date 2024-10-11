Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D3999AF6
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 05:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728616240;
	bh=F/YhnhwnZdpxA5ZuYVV/6W0Q9c03/PE0kBa73QF3Cps=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DRG5h0N4RfMW1bblpZHUglJrEFdXCOC/BRkvlQ6uE4IHTszCQWxqPJCftJuMjLRC/
	 k97PgiQvyHARp0kqbQeWIgjK+2C7FmQ2zEySTIMTHBn+umooUAxccB4LC4j0g0vgjf
	 mGSMjIRrkseaJ5eRqcorUPeWB8ONBNcAs9QwaRqGaw2LvePHkFF++p8veOzge0F+LN
	 V63AjB/xuDYtt5vyKiFnsfdJhIclxEypnC2EmALPeRjexlkauPyEG7QJklKYMsBiFv
	 avzxN1NYav0CiVE/RlDZqp/9TYztd4587RX7BkTIwu/CDu9xwEfzefSUVixiM5w6fA
	 1o3XmirCLpyQg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPs802FM4z3brD
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 14:10:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728616237;
	cv=none; b=L1nfK29E+zMvC06KaxtAww18emJd+dhENb0/OrHvpnmVBOBAmkW3NML2dva/RV2vLx/EWzckbsJaBHR6hrNifcHeU0uAJie4FVTSjRyjcasXWvER9TF59btfXI6KxDt/56syyWIgQ5fu7IVyFfbjtUlOMxxLZhKa3ydQlh6oonm/BvVN4juB/RZrj4bcyVdeVkAWfY+7T/9uDWT4OvlsPb8QJvVOOF91mS4ty+rstHOtqrRQmiV4+Dq33b+rKzi8e3wIe+9O41sQzgmURtkZGB8XVrn/LOpRHJEjXii5VjA3xjSMdiaN84QhFnBTKqGlC8DX+q4w4sG4vhLJ5xll5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728616237; c=relaxed/relaxed;
	bh=F/YhnhwnZdpxA5ZuYVV/6W0Q9c03/PE0kBa73QF3Cps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E4bLyapnhhIbr/Z6XVldspM/5QSpLQbIGer4pJe7GRC+0EflONpYAOttc+V1ZKddrWuOYQBpE4vaSZgnC01UvKK8amKWgeb5cP69yWKDdIbJDoTNTbep2W7jcg7Hh4eHeVAvYY01+bF+NGOUfCQgVkLgvk1fxQl8GYOhxRgdkZrDOYP/jU2oOL0W2EYvsXfUz5mfGROM6RJauumqQB9Q0Q99hsri3TL/Uqvmp+TWnIdwAxpOnSr6IUTmfSIiYfK9i1JUZ2llO5XvFdrrkM15fHD8HliQeuws3Zpoak4HZ93koehdWjUR/2KhLyReGCkbE5QYlzZExyZRoTYlBpLJpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DntyGKQh; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DntyGKQh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPs7w6Mmpz3bcX
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 14:10:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6DCB8A44E2F;
	Fri, 11 Oct 2024 03:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2100EC4CEC5;
	Fri, 11 Oct 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616233;
	bh=6b25pjgk+omSednQLQU3IFag9Hwh3O+MVcY9W5utO34=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DntyGKQhWSzq52qJFSsEWzkDb1dXQ3q2VlF73pHDHIfIIiCeDKSNGBIC1uhq013Sy
	 Ncwbqg3eB+jC3lh2bV6Q6FYZMCvQg5AnPgXruk30zIsRB+bHsfE1anDw4uBfw/yQ91
	 vCZrvDSRf+/oENVvdk4vwiMJIcT3gc8TSLWGLh7Dk8L+17UW5VvuVFQ22Z9vSH9fpx
	 vQ7+u/5WMdaLZqDfaSvuvqTPshvA0v8PIrd7E2i+UxufvKglswryvBvYOlHUH6nihK
	 qs37pyjo27UWrvY0qJ0qJina+3qJgwiKORjhsSzecOv9QTGDDV9E2FKVzDmrr3ZH/Z
	 VPTpyG7fRVGtQ==
Message-ID: <27aeda6c-dd0d-4cef-b071-18499b1b3e70@kernel.org>
Date: Fri, 11 Oct 2024 11:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: ensure regular inodes for file-backed mounts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <00000000000011bdde0622498ee3@google.com>
 <20240917130803.32418-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240917130803.32418-1-hsiangkao@linux.alibaba.com>
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
Cc: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/17 21:08, Gao Xiang wrote:
> Only regular inodes are allowed for file-backed mounts, not directories
> (as seen in the original syzbot case) or special inodes.
> 
> Also ensure that .read_folio() is implemented on the underlying fs
> for the primary device.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000011bdde0622498ee3@google.com
> Tested-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
