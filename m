Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED55F119
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 03:59:34 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fLkp27FXzDqYk
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 11:59:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DafuIMzR"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fLkd07HPzDqXm
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jul 2019 11:59:18 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id w24so2204407plp.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 03 Jul 2019 18:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yBNyJBnqU/lYe/Ozz1jmxOlaF/PmqyD3BLJwt7wrtGU=;
 b=DafuIMzRmRoFk2EtihZ6K9OJnyDWcYNsPH7F4xqO38yVAcGxqFgy2ppKW0kLW2CB8l
 +Cl/DKFQwgopwOtQNq4x/amG+iW9DSq9UFXBxoP7PzwQ+x8lXt1l3II/rmf46niXX0YQ
 l+7PSi6Z3xLB1hFmW4N5rwVxWS1r0RUseTBaXBBT+pdO5TfHVgfLSoQVUzUzFNn6LLLk
 tklOtKZ0IsayBMkMNGdwT8Kt83LjaLPI1PoU8I2KHegSuHkMF42Xnbkcg2R8ykbiLv5s
 /PGeadBgf9cOKDIvujjxOCkmnPobO44M4GTLfFevleShqEpZvooKdQemKCO8OXTqBNGM
 UU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yBNyJBnqU/lYe/Ozz1jmxOlaF/PmqyD3BLJwt7wrtGU=;
 b=U+hRDjWhNrDkSfoTc0HfMlylGNidmGzAvGWfdNBKlcd6TGo0E3IdbnCV8cyt7E4VU4
 KCqkJrC0LSVgibhuVn4V5FRuynksbJp8VaIecY17ronU35lG9UudpaSbSlf0+A+iNQNY
 Hf5un7kSanys59oZbFpdQPnfYGnFYFemC+aV/AJyEu5hs/y7061KjqzuRG4DZ65h8ji+
 whx5edLmvmdiK+UA8oKTh0K3L/jDfAizE/n40diQGGV3gmQO+Q8GhjxvYp4ULyF95sik
 QsN0jL79Hx38Ho/xQVCp+plzH77y7U5/vvsmr3DHd1ZD3CsGhQZAJYuWmaXCejkx9aBs
 I3EQ==
X-Gm-Message-State: APjAAAUzSPextZFUG0g+6lbcnnjhgb1vQkaAkheX9x+q7nRlGLOUcqGx
 iGd9I5f9ghyKE3bEuIZ/utw=
X-Google-Smtp-Source: APXvYqwzCTWt23oxzdyRl3RG83l5rEiHGsDuTVXrO82oG40/lICiq6krwvwERXdF37c9iMzrvV7HNw==
X-Received: by 2002:a17:902:b592:: with SMTP id
 a18mr46612654pls.278.1562205555190; 
 Wed, 03 Jul 2019 18:59:15 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id x25sm3582345pfm.48.2019.07.03.18.59.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jul 2019 18:59:14 -0700 (PDT)
Date: Thu, 4 Jul 2019 09:59:03 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190704095903.0000565e.zbestahu@gmail.com>
In-Reply-To: <20190703162038.GA31307@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
 <20190703162038.GA31307@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 3 Jul 2019 18:20:38 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Already check if ->datamode is supported in read_inode(), no need to check
> > again in the next fill_inline_data() only called by fill_inode().
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > ---
> > no change
> > 
> >  drivers/staging/erofs/inode.c | 2 --
> >  1 file changed, 2 deletions(-)  
> 
> This is already in my tree, right?

Seems not, i have received notes about other 2 patches below mergerd:

```note1
This is a note to let you know that I've just added the patch titled

    staging: erofs: don't check special inode layout

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-next branch.
```

```note2
This is a note to let you know that I've just added the patch titled

    staging: erofs: return the error value if fill_inline_data() fails

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-next branch.
```

No this patch in below link checked:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing

Thanks.

> 
> confused,
> 
> greg k-h

