Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E122693
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 12:11:50 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456Hr316qhzDqJc
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 20:11:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=hariprasad.kelam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="prPrOvv+"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456Hqy43hwzDqDY
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 20:11:42 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id c5so5333788pll.11
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=3nXBmIh7/vFkJ4Tm2l4dtTScuooDKNvEF1jpFXfvwsc=;
 b=prPrOvv+nXzlq37dw9S0qdmegNQMY9mMQmGxVdosiPQlKvmQHZwzyNNaISmaHYISPL
 X+MnJT//NcQ21npBKca3WpAApauj41TAIoPfE8Yn1PKHUg9dRm+3twylCz1VcUhpj9AY
 TcBLFLBaEYI9qMBT/BXar0olvQLimM1sWud1T1/GfOO13CqMdqbUwAOF6akeVMHvShBG
 389EvyUF/W8ChWuTLWfKobvsEmxcppXOOvx5AbluLHXBrSxVUDsPtbnSGtuNc47AipJP
 LrRYAfePFA7lz8yV6lvkrbyhb38/XY3u7Pi4ItdkOP+VRZUORZzNtLVvNvBwQHUVJgbK
 jkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=3nXBmIh7/vFkJ4Tm2l4dtTScuooDKNvEF1jpFXfvwsc=;
 b=s+ZFXHGZ488DBQDU59WufA0pta6JiiqJBDzRBLXU0Rgye9gw9iJk5Iu99HRt30FuYX
 ucDEwvXm3wR9UHp3PkirxgJttubf/AIRRNGJuaes8GBMlFPSVg1Yw0uHr8v15JkVMG3N
 wz1YWNE9LDt0yKg7D7FltuDlcK2WDhbBD+pQm7o18y/Mq8JeXRauG6rLQEw09vT5Rd9u
 lmDZ++HcVbnkN74Gs7nu6dptdohYujhdJIRcP5xcXhf+giwRxjOc7qy1dbHl9lbOo51X
 V190HFBZX8dEe2FZTcP4nYboJiB0kXn7j/snSCt+uX+5rGMa2L756hpaQKF1CVW2HBWI
 q/CQ==
X-Gm-Message-State: APjAAAXdCoUVsaLjhpccbqkL4+NHGs4icog7xeP4eVBTeJY8c4Vaihyy
 UmOsNKsJ/ydkVW7doyqdfvI=
X-Google-Smtp-Source: APXvYqxWU8wpTJXHBJp+Rkhz1pg1a0Wph4MXE9asWBt0UGUSJ69BeobNf1W2Emh5hysyAcKSb/AXeQ==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr17066355plc.21.1558260698892; 
 Sun, 19 May 2019 03:11:38 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
 by smtp.gmail.com with ESMTPSA id c17sm9740268pfo.114.2019.05.19.03.11.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 19 May 2019 03:11:38 -0700 (PDT)
Date: Sun, 19 May 2019 15:41:32 +0530
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
To: Gao Xiang <hsiangkao@aol.com>, Gao Xiang <gaoxiang25@huawei.com>,
 Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
Message-ID: <20190519101132.GA22620@hari-Inspiron-1545>
References: <20190519093440.GA16838@hari-Inspiron-1545>
 <b32e6bca-60ec-2004-f1d6-16d2b8a478ae@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b32e6bca-60ec-2004-f1d6-16d2b8a478ae@aol.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, May 19, 2019 at 05:50:40PM +0800, Gao Xiang wrote:
> 
> 
> On 2019/5/19 下午5:34, Hariprasad Kelam wrote:
> > fix below warning reported by  coccicheck
> > 
> > drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
> > instead of if condition followed by BUG.
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > -----
> > Changes in v2:
> >   - replace BUG_ON with  DBG_BUGON
> > -----
> > ---
> >  drivers/staging/erofs/unzip_pagevec.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
> > index f37d8fd..7938ee3 100644
> > --- a/drivers/staging/erofs/unzip_pagevec.h
> > +++ b/drivers/staging/erofs/unzip_pagevec.h
> > @@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
> >  			return tagptr_unfold_ptr(t);
> >  	}
> >  
> 
> I'd like to delete this line
> 
> > -	if (unlikely(nr >= ctor->nr))
> > -		BUG();
> > +	DBG_BUGON(nr >= ctor->nr);
> >  
> 
> and this line.. I have already sent a new patch based on your v1 patch,
> could you please check it out if it is acceptable for you? :)
> 
> Thanks,
> Gao Xiang

Hi Gai Xiang,

The patch which you sent has all required. 
Thanks for the  patch. We can ignore this v2 patch.

Thanks,
Hariprasad k



> >  	return NULL;
> >  }
> > 
