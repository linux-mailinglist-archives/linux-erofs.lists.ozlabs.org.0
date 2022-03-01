Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3734C83A7
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 07:02:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K768z0FfFz3bpF
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 17:02:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646114547;
	bh=NmarBrZsXxqgujowhCRTIe88ugVRWJmcpd9/a5sYSsY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KKCgNSsUkw73ROvtRIBcwqC7ctvRrf9AUadcEEtYBKzYmBVZE6+p8LQ1VlMRTzk8H
	 PgbTrwO44HLxQSxh8PcHhFsrTBcjH+Wi0HhaJtVj/DR4DSJ3hlvdXSmbqeCGe1hhh/
	 xXuKriuRi9D7mHvjc/CRsSdAwb9JbnmDC+2LELqyHurmavtakKUEcB+prqZbUODaMX
	 Ldogd41Q2mScdK6QcQTuacIOq27hJutJ3+CZ3EJ8Tq+TBjKhju6fh/PT5ofGlHgCyE
	 Oimz6g/tW07NAZIvZEv7c9ujFX06vu55iH7ahVh4R8OD6q9LyLzrEJdUTmEOdde9VE
	 VEPRH8totYliw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::932;
 helo=mail-ua1-x932.google.com; envelope-from=dvander@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Hqasx7+S; dkim-atps=neutral
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K768w0HhWz3bP1
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Mar 2022 17:02:21 +1100 (AEDT)
Received: by mail-ua1-x932.google.com with SMTP id l45so1524446uad.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Feb 2022 22:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NmarBrZsXxqgujowhCRTIe88ugVRWJmcpd9/a5sYSsY=;
 b=0eBguDzzRY3lpishtOHzRRlIe8WNGzy8IpRT/SYHrzFkG0XxnYIDoKwqSxEAgOhMTS
 SlfI4rNc8rKJ2g/5DCQzNey0lk2o5cPPhVWuK8XO7PeQ0kazu2GSeUZfcVZ9JUOKzbys
 ekeLFGpwilBvHAgp+RbL3+AwnkdYlSdz9v7sM3ReXm506Mv6gmcKqhee6BsxzzcFZN9I
 eclbVXZiuEjUzHHeeD6T7ywjg32/izd/CFhOgPuPcETxhGoKs3WxaeKhxpfRecQV6K+R
 sjNRbjHRDYD88xvRdZtTJoloFlGYVNfVksMJrZIoyOBz6rvvJMFNstmVTCjtzOJnkR3M
 lA9Q==
X-Gm-Message-State: AOAM533VvpmCMA/ZzdA8VHSEucyIk3x2q7VJ4wVaAGjU3OSGSXvT7WRd
 u2OhtXkvAijjBk3/ZZCnXmCyNcaoPMnbxjRiEEoPXZ4Lyc4UbMYf
X-Google-Smtp-Source: ABdhPJzlMQUCstivjMWc9wFnqCXuapvbvNhh9pM6FB/ZnVwcfuTjP2Exh7Sihibl61f4hxfLbUEepk2sYX5I+LjoGNo=
X-Received: by 2002:ab0:2809:0:b0:341:f4aa:829d with SMTP id
 w9-20020ab02809000000b00341f4aa829dmr9220853uap.42.1646114533987; Mon, 28 Feb
 2022 22:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20220301041139.2272220-1-dvander@google.com>
 <Yh2u2Iab7BjUg3ZH@B-P7TQMD6M-0146.local>
In-Reply-To: <Yh2u2Iab7BjUg3ZH@B-P7TQMD6M-0146.local>
Date: Mon, 28 Feb 2022 22:02:02 -0800
Message-ID: <CA+FmFJAxEkGZZjjuoSthFbdBXy5uSmk=JkNYw6FU-Ls7SUecTw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use mtime to seed ctimes
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 28, 2022 at 9:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Yeah, I agree I should think more when I planned to store `ctime' at the
> first time [my original thought was to keep metadata time (including
> uid, gid, etc..), so I selected `ctime' instead of `mtime'].
>
> Should we change what's described in 'Documentation/filesystems/erofs.rst'
> and even rename i_ctime to i_mtime?

That's a good idea, I'll repost with a patch to rename to mtime.
Initially I figured it was ok, but the "ctime" name would cause
problems if EROFS ever stores both timestamps.

> Also should we introduce a new compat feature to indicate that new mkfs
> records mtime instead?

Will do. Is there anything in the kernel that would need to care about
the new flag? (It looks like no but asking just in case.)

Best,

-David
