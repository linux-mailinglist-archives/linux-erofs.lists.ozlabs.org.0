Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB797A9B7
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 01:46:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X71l45Zzhz2yQ9
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 09:46:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726530362;
	cv=none; b=RBtE+PoA/zBSI5bb/E5YOAj148Lgxsys5YPWW+ApGMft2//Ff8yCcbe1ylgAvgp+eQ23kw62Wa8uUPQMVMlzSTxhWszPdL97KDlAK2UHFz3X+brSoySYuCajs7MJeVoMrIwTsiM5hzSmqFEgSvah5z5Q6rThJTJNmcHx7pzdFJieha9OjA9SOn4UNeVU+d4UScE/k+CwiTIN3aY2zKPHeE+j/Kl7fHtvnSO5pg0C4nQTTZm73PY8hlQ2c+gUB3UQen2OLQ8TBGuxTuqa0XMpcJ7ukVBw5GBaROKc1IjFJH4OQ0Ht5K52ffD3ki1JJbo4YIrcq5CehaqIBoDbQmEw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726530362; c=relaxed/relaxed;
	bh=B4rNWlBdjfL9smwu9MlwgNfDAPiZe3aLTcpYgp1odwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2/lAi/XTKOdFH8RHTbOl/HjjnlzhjrIP+oEn/es1uwIY8WNtxwcQX2ZAW1GxycmCnNo6mh7FfQ2osuP5c7Xlg/cVEPdxtVT67kxqbAYsxld1kMkqtcMWgdtSdfhvTjyEy4Y6zVJHGi/XpfJnBUPEfvgurUFfnoxE+5hbSVNNHr2WlLxBSGzeRSJczautpYAyoMlzJQEd2EL7xC3+fLvJzgqQTmfNtWUH65MMsM8cNPKkYDYbU13vovcCDZQSxT+HpZlvrEm6my2rKUtUDd2u3qMuXIKVzQ/JU8lSMwrBlU76jLeLcdnPKhSoWjd++BEWdRdtgTHlGaDdZ3SS1ZOjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lhmtCyxd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lhmtCyxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X71kw4C1bz2xHw
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 09:45:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726530352; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B4rNWlBdjfL9smwu9MlwgNfDAPiZe3aLTcpYgp1odwM=;
	b=lhmtCyxdXfBp0bpQdJmjzHzw9f+mvRS5lPNPaJ5vMYBvJyU0HgFWFNry5Yx/o9oVcbiUxqZ/atTxdJ1XF3IgULR4b9l6L7rvjjApsif/WadSgxgBQV5G7BojatxvRYhnO0cHGMwiembqDys4ZiFiRON2eUPO9hngpOyp8bUDUpg=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WF9HTgY_1726530350)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 07:45:51 +0800
Message-ID: <2948509e-f250-4723-b618-d737de5ddb56@linux.alibaba.com>
Date: Tue, 17 Sep 2024 07:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Greg KH <gregkh@linuxfoundation.org>, Yiyang Wu <toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <2024091602-bannister-giddy-0d6e@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024091602-bannister-giddy-0d6e@gregkh>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

On 2024/9/17 01:51, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:13PM +0800, Yiyang Wu wrote:
>> Introduce Errno to Rust side code. Note that in current Rust For Linux,
>> Errnos are implemented as core::ffi::c_uint unit structs.
>> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
>>
>> Since the errno_base hasn't changed for over 13 years,
>> This patch merely serves as a temporary workaround for the missing
>> errno in the Rust For Linux.
> 
> Why not just add the missing errno to the core rust code instead?  No
> need to define a whole new one for this.

I've discussed with Yiyang about this last week.  I also tend to avoid
our own errno.

The main reason is that Rust errno misses EUCLEAN error number. TBH, I
don't know why not just introduces all kernel supported errnos for Rust
in one shot.

I guess just because no Rust user uses other errno?  But for errno
cases, I think it's odd for users to add their own errno.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

