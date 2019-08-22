Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA898DC7
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 10:33:29 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Dd8j3k50zDrHn
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 18:33:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=richard.weinberger@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQ7p6IVC"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Dd8c2SfzzDr3b
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 18:33:20 +1000 (AEST)
Received: by mail-wm1-x342.google.com with SMTP id d16so4840474wme.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7EauMan5wC2oHmJwa9VSCeeLzs1qH85S7tn6KqheO0Y=;
 b=OQ7p6IVC1NIw7fex5ur1IYa1YmEGcmleiVeN1rAeX0LVjJz/+s8L+/4nTeG0Tr2Zm7
 KOdjCjmLzgRxyDZjhzwqrfcOYWmX7FWZv8dwg8zAJOdeAQqNRxSiTXIiw7hwH7dofsmW
 CMveJQR7Vtpbpz95ituoxFtAjIhxDa0pF6ZgZvqZuaiPAe4Z75dCgIrcLYaoBDHnN0vF
 r7jwHMqyAir8eYR8R4oYIEpdspGiSRf1vVIYgjpklTqJSbOTmKcQuUOGJxlneCaO5wD3
 hyXv99UXj/cNZ92Fi/DurOZsSnoGXeDaOwQDzubRKWZ6rB0ZDZaABc4b6rWXLOuYikjn
 7Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7EauMan5wC2oHmJwa9VSCeeLzs1qH85S7tn6KqheO0Y=;
 b=ocXssT8tY6WmhUkldldkLZWcdsekuvt3KcP3lfqsX9sdobkYR+dsySxOvQ8re+L37E
 BzLcOiLHMYHDmR43GlytnmqrSLXpb0VU7WBFtn0IZpqtdWqWqYE64fhjkHU8cQKqjtLs
 THPtjmuUCk3NFl95Xa6oteW6xQ+mXUWuEIu7KoZq+mfSh5Dsc5M+6/LtZAGe8ahpiPa8
 GeBOGKz3LZnWiJC0nXvqhkON0zykqtme2REZGJ89MXe7uMBDk/gu0wnqdo5bGyhbkZh7
 1UW2C+kpcZPUdsUs24DQ7fDOENXXJ6LRgPVfwoTuCAOYfSFju+G/fgHrF+ibZboVoDnK
 4ZWw==
X-Gm-Message-State: APjAAAXIoVrbR7Hh2UyesnlFjxhta6reGcnOwvjQWs6JMLFYap9Miaj1
 flRYliG4wyBZMRUP+LpKowAfPABbeu+HYek180g=
X-Google-Smtp-Source: APXvYqwp3ugo/OV/r/Cwj2DfvvMbvNm+soB016hMmOviIAU2t8QWMrxQSxMeAbb9I1qyMe3BKgqWpfLfM68frYMNOPU=
X-Received: by 2002:a7b:c155:: with SMTP id z21mr4840886wmi.137.1566462793252; 
 Thu, 22 Aug 2019 01:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 22 Aug 2019 10:33:01 +0200
Message-ID: <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
Subject: Re: erofs: Question on unused fields in on-disk structs
To: Gao Xiang <hsiangkao@aol.com>
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-erofs@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 22, 2019 at 12:03 AM Gao Xiang <hsiangkao@aol.com> wrote:
>
> Hi Richard,
>
> On Wed, Aug 21, 2019 at 11:37:30PM +0200, Richard Weinberger wrote:
> > Gao Xiang,
> >
> > On Mon, Aug 19, 2019 at 10:45 PM Gao Xiang via Linux-erofs
> > <linux-erofs@lists.ozlabs.org> wrote:
> > > > struct erofs_super_block has "checksum" and "features" fields,
> > > > but they are not used in the source.
> > > > What is the plan for these?
> > >
> > > Yes, both will be used laterly (features is used for compatible
> > > features, we already have some incompatible features in 5.3).
> >
> > Good. :-)
> > I suggest to check the fields being 0 right now.
> > Otherwise you are in danger that they get burned if an mkfs.erofs does not
> > initialize the fields.
>
> Sorry... I cannot get the point...

Sorry for being unclear, let me explain in more detail.

> super block chksum could be a compatible feature right? which means
> new kernel can support it (maybe we can add a warning if such image
> doesn't have a chksum then when mounting) but old kernel doesn't
> care it.

Yes. But you need some why to indicate that the chksum field is now
valid and must be used.

The features field can be used for that, but you don't use it right now.
I recommend to check it for being 0, 0 means then "no features".
If somebody creates in future a erofs with more features this code
can refuse to mount because it does not support these features.

But be very sure that existing erofs filesystems actually have this field
set to 0 or something other which is always the same.
Otherwise you cannot use the field anymore because it could be anything.
A common bug is that the mkfs program keeps such unused fields
uninitialized and then it can be a more or less random value without
notice.

> Or maybe you mean these reserved fields? I have no idea all other
> filesystems check these fields to 0 or not... But I think it should
> be used with some other flag is set rather than directly use, right?

Basically you want a way to know when a field shall be used and when not.
Most filesystems have version/feature fields. Often multiple to denote different
levels of compatibility.

-- 
Thanks,
//richard
