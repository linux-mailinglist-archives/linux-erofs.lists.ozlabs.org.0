Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE44D5408
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 22:58:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KF2yR6wWjz306S
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 08:58:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646949536;
	bh=1nfn1bIaLIZUKS68JBzlRGB97kRpVOmBRH421qOBODI=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WS0fdEu135jLUGHVe86IMuRN9UcznmHPhPTbgO8o1ec5rj7RzTb7mtVtfC7NRTz6W
	 S0KyIVfiloqoz0N4Yv5GQ4J2qV1GTp4ifo3fFs8RQns8ppobsIA2dR84I/nvOsaWAX
	 3SFeM0FUfvcjMA0JQ45/MA5+ISgFzMIrDEEaW7qdi2EwNssTgIiI6TKjyBVEhbpk/+
	 H5eCPaooTmqYK7J6lLL473pCX86KgqbajiUjDHtFVEQpH9ej5YMx5J414XMDU4DPiz
	 cWBbK8zn3Pm/fPWT23EgKQnkZw8jOfQq3HZSarafu194Zhj8zC/tjm/2d83KFpOSN7
	 JyGNkII/0PLYA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::e2f;
 helo=mail-vs1-xe2f.google.com; envelope-from=dvander@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=WPl+59W2; dkim-atps=neutral
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KF2yL3Vxmz2yhC
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 08:58:48 +1100 (AEDT)
Received: by mail-vs1-xe2f.google.com with SMTP id u82so7625477vsu.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 13:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nfn1bIaLIZUKS68JBzlRGB97kRpVOmBRH421qOBODI=;
 b=HzlQlUoAWdiczUGhV5Isx8QXMvV9KNHEkazEl6Aa+4pMhtAAeuX3p7UnfaOprm9EXO
 eL3NB4cxPWLQWIyCXWsdPvggd8FWEafwZY/r6dofqO9c6DB+LiL7o6XQZdYe39c5W5ZV
 GIJIrbI8YMG0Tsd1GwM+U+k+ZFjSMkHRWw/LaCQaUBwYBOuyzd1SIa06bp21B9sXbQD+
 usuvT/YGm628cqnHSu7ml5k6EM8rMLP24stKTstQAJ/OAyK+rCwqHKadcnq8ESodaPfr
 zKxi3s+uptIy70CqovREnMYFRSuWI55Txi2Bon/hZZov1FErCTTChCOqm4yNPHzVf2R5
 ir6Q==
X-Gm-Message-State: AOAM530NWoXgc3LXvxT452T4f5Fkl9kMJvflkFBmljcjQzLcfXcRuMnf
 r0H2cdNUvIiDLiVSGSBK85JpLtbhhBXmRbbGKXiQE5XDONHpIw==
X-Google-Smtp-Source: ABdhPJwqXwAEp3HSpaCOWJU0wMKIg4vUAx85Dde9UFTe75Fv2kTTKaJ140f0jQ0MlX5/DBP9xQE2XTk0LZ9Hyfs0BVQ=
X-Received: by 2002:a05:6102:3049:b0:320:b4d8:d40f with SMTP id
 w9-20020a056102304900b00320b4d8d40fmr3805433vsa.41.1646949523997; Thu, 10 Mar
 2022 13:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20220301041139.2272220-1-dvander@google.com>
 <Yh2u2Iab7BjUg3ZH@B-P7TQMD6M-0146.local>
 <CA+FmFJAxEkGZZjjuoSthFbdBXy5uSmk=JkNYw6FU-Ls7SUecTw@mail.gmail.com>
 <Yh24oH+pOWGbx70g@B-P7TQMD6M-0146.local>
 <YiA8tH3fdQQqI/Jf@B-P7TQMD6M-0146.local>
In-Reply-To: <YiA8tH3fdQQqI/Jf@B-P7TQMD6M-0146.local>
Date: Thu, 10 Mar 2022 13:58:33 -0800
Message-ID: <CA+FmFJB=TKb7ZOpa38k9OBeX3+2nVFYpKx==Tk+6oP78CAvE+g@mail.gmail.com>
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

Sorry for not replying sooner, things got very busy - I am working on
this now and will hopefully have something tested + uploaded by EOD.

Best,

-David

On Wed, Mar 2, 2022 at 7:57 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi David,
>
> On Tue, Mar 01, 2022 at 02:09:36PM +0800, Gao Xiang wrote:
> > On Mon, Feb 28, 2022 at 10:02:02PM -0800, David Anderson wrote:
> > > On Mon, Feb 28, 2022 at 9:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > >
> > > > Yeah, I agree I should think more when I planned to store `ctime' at the
> > > > first time [my original thought was to keep metadata time (including
> > > > uid, gid, etc..), so I selected `ctime' instead of `mtime'].
> > > >
> > > > Should we change what's described in 'Documentation/filesystems/erofs.rst'
> > > > and even rename i_ctime to i_mtime?
> > >
> > > That's a good idea, I'll repost with a patch to rename to mtime.
> > > Initially I figured it was ok, but the "ctime" name would cause
> > > problems if EROFS ever stores both timestamps.
> >
> > Yeah, I recommend that we could use mtime from now on, but in case that
> > users are confused, we may need add a compatible feature to indicate that.
>
> Would you mind sending a kernel patch to rename them recently if
> you have some free slot?
>
> We're in 5.17-rc7 cycle.. I think we have to prepare patches for
> 5.18 now so we can use new timestamp behavior from 5.18..
>
> Thanks,
> Gao Xiang
>
