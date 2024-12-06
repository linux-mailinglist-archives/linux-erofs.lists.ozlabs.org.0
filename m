Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8949E6A3A
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 10:33:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4R092wKCz30Yb
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 20:33:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733477623;
	cv=none; b=AqfHbBOsmsMhZeoihEXDzgA3cFAjjwXoGCg2ABMsqwik5dJBC4Os4CZWWzDctfJAXQoNmsnrW3SRTv1RVxk+502WqCvTiuEej2N69IBLHMWOz+nN+ciH/5tsR2OmBManWWuCWkw7fhEb17SlsItN5AEiFh716snd9J8bvy3CgBMTw1G0IvHUFz9nex/LGGy/01B10P/QjYLf8tRw8WyjStGy16L22QYuM2BVFUWAFjAEuU3IfkYkB03CuXXhxjN7tOX44hQzEtdofJ+d3/uR7bL8MpTZDKv/4EGqsZbZrJ4NcQScUvthgDRXEC+6An2WHlN/GAme6AxDZR4n79LUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733477623; c=relaxed/relaxed;
	bh=5w2uRENwbB2VqX+UKcLK+uSQFgEs5YDM2uCPsEO3Vnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7Gwx2SAOztufCxHvhW5//r3U+jHKA8Qcuk4fCzZqpgAsoIQuxmnHJzBMYVb/mjuGE3nhIO/wwvqe1dziDjoqt3x0h6SnPzl5Zm5ACTsR0fQVY/oYKNoWZmb6PXERMVKeVKDBF50CxYBsNJUyERxmsNNFJfCd2oTQ1bCc3bRxxS7QVfX6u6HKOCaeIyFwgM2bdCZ71VObtY8OkSRhnhnw7jXpGWuvo7wbW0i+dVyA2zxsSsCioNCzoELE48AlbhP3ZsKfYl29m4nO+AELlqjTv0JlqBYpghd1943cj7ngVmdZ8EUn8oNovKptDBL4dyus9q9oe0KdCjdrvbEmKDiMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bcfWnrgw; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bcfWnrgw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4R036PvGz2y8d
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 20:33:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 06DE2A44100;
	Fri,  6 Dec 2024 09:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B90EC4CED1;
	Fri,  6 Dec 2024 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733477614;
	bh=rRB/+ip4+GyKs3Swmd1fLJCGBhdr9D6ubt/r5hQa7jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcfWnrgwDx0RByNlMbhu8sapK8t9O+K+xNyLlS0NuhoV+pAwKJw6fGR496jMqYY9W
	 nyKY7+bpMbO2/op7JiEq06htPw1PtdmxM0iBtb2sHskauNJd5Ekg9oAFQzV7Z9zeAA
	 rU0W87sCVmdlKIdyoD0NQiz5mO0EY/DL+7mmCNek=
Date: Fri, 6 Dec 2024 10:33:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Patch "erofs: reliably distinguish block based and fscache mode"
 has been added to the 6.1-stable tree
Message-ID: <2024120622-prankster-lagged-01c8@gregkh>
References: <2024120228-mocker-refinance-e073@gregkh>
 <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
Cc: Christian Brauner <brauner@kernel.org>, xiangyu.chen@windriver.com, stable-commits@vger.kernel.org, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 06, 2024 at 01:05:21PM +0800, Gao Xiang wrote:
> Hi XiangYu,
> 
> Just noticed that. Why it's needed for Linux 6.1 LTS?
> Just see my reply, I think 6.1 LTS is not impacted:
> https://lore.kernel.org/r/686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com/
> 
> Also, it seems some dependenies are missing, just
> backporting this commit will break EROFS.
> 
> Hi Greg,
> 
> Please help drop this patch from 6.1 queue before more
> explanations, thanks!

Now dropped, sorry about that.

greg k-h
