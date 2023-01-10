Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52384663C20
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 10:04:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrlHc1W1Fz3cBF
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 20:04:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qRqc/tpn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qRqc/tpn;
	dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrlHX1tpwz3bdS
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 20:04:23 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id b17so5004452pld.7
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ7SUDme+ylcKOYsVIc8VWSJeE8UlqmYJ8RnJXfYjyw=;
        b=qRqc/tpnIYm11hG8NIw4BxiUIoyYtWxf59Q5nzx7LvnCLKqgHUtEsw8IDHIbrvnnn2
         8F4qMKiN4MiOL6kGQ7y0NzFOzR+zyBpbvA0zKbm2AIVJlO8n6ftD/xWmB6hOfP5tPJub
         Iudz40gqs0lh9SOs1G4JRy6RQf4shoHrwL3e/DXE8Ai2XWbAX+HCamCuWYqaudG6uHt7
         F++OmXPGPvUgym8PfSlIiNp48dNNRe3/YPJH26Zcq1iiVH80oh6Rbx63I+FoTauCVY31
         uV744mQ/6CG4c8vhIZgEhG8Bq3YLxYRydE6+L2enq/hzpejBtkkbOch844WuH5H9CI3/
         6iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ7SUDme+ylcKOYsVIc8VWSJeE8UlqmYJ8RnJXfYjyw=;
        b=7RAhcYexjVdKrRXfrlnPUAAwlrmd73EsOnm014tQdTGWMv3vcd/xJHN/+vGNBrUTTP
         1D/7xlbyT2lfrs0ghO97BIQ3O8sBqzC4p0Dlp61IMjPS56z3t6lV2DWfD6wTLD72lQJD
         2lja5OkeMfsxmXI7ksUaY3VSHIakadIzC61mq3j4VYYSAMi78/L5cdm2TxGhyezezgJF
         vOS0PSqxkrMUA/eyLUpN4rYWdzz8WKroea5XpxDTnPOTB5JZZL2HGrvJo2tPyvcjpOWs
         6WEEBdq+HT/b+oYDbR3aCfAMvdfMRyQf+Pe823Hhg+Vlh+5aVzsJkfbirgnsCfL4TTnx
         tk0Q==
X-Gm-Message-State: AFqh2konV4sLecAAlXUsvcqGg0I015vYLXwmM0r7WMmae81ILiPExwpZ
	Oi1hIG3YBuDHZq27Zt5/79Q=
X-Google-Smtp-Source: AMrXdXtaVjY6b8UTDTf+lfz8MXtffuY7hwrlWJeMNRXbMn2fNRil0dd7pqvBu+1Y19NlIXSMQfexlg==
X-Received: by 2002:a17:903:32cc:b0:189:129e:92af with SMTP id i12-20020a17090332cc00b00189129e92afmr98182421plr.14.1673341460247;
        Tue, 10 Jan 2023 01:04:20 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b00172cb8b97a8sm7614509plj.5.2023.01.10.01.04.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jan 2023 01:04:20 -0800 (PST)
Date: Tue, 10 Jan 2023 17:09:27 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Xiang Gao <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] erofs-utils: lib: export parts of erofs_pread()
Message-ID: <20230110170927.0000514e.zbestahu@gmail.com>
In-Reply-To: <24d6bb29-d81e-14b7-141d-c13477819143@linux.alibaba.com>
References: <20230110084959.1955-1-zbestahu@gmail.com>
	<24d6bb29-d81e-14b7-141d-c13477819143@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 10 Jan 2023 17:00:33 +0800
Xiang Gao <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> The patch itself generally looks good to me:
> 
> On 2023/1/10 16:49, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Export parts of erofs_pread() to avoid duplicated code in
> > erofs_verify_inode_data(). Let's make two helpers for this.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> > v2: use parameter trimmed instead of partial
> > 
> >   include/erofs/internal.h |   5 ++
> >   lib/data.c               | 154 ++++++++++++++++++++++-----------------
> >   2 files changed, 92 insertions(+), 67 deletions(-)
> > 
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 206913c..47240f5 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -355,6 +355,11 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
> >   int erofs_map_blocks(struct erofs_inode *inode,
> >   		struct erofs_map_blocks *map, int flags);
> >   int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
> > +int erofs_read_raw_data_mapped(struct erofs_map_blocks *map, char *buffer,
> > +			       u64 offset, size_t len);
> > +int z_erofs_read_data_mapped(struct erofs_inode *inode,
> > +			struct erofs_map_blocks *map, char *raw, char *buffer,
> > +			erofs_off_t skip, erofs_off_t length, bool trimmed);
> >   
> >   static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
> >   					  erofs_off_t *size)
> > diff --git a/lib/data.c b/lib/data.c
> > index 76a6677..d8c6076 100644
> > --- a/lib/data.c
> > +++ b/lib/data.c
> > @@ -158,19 +158,38 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
> >   	return 0;
> >   }
> >   
> > +int erofs_read_raw_data_mapped(struct erofs_map_blocks *map, char *buffer,  
> 
> erofs_read_one_data?
> 
> > +				u64 offset, size_t len)
> > +{
> > +	struct erofs_map_dev mdev;
> > +	int ret;
> > +
> > +	mdev = (struct erofs_map_dev) {
> > +		.m_deviceid = map->m_deviceid,
> > +		.m_pa = map->m_pa,
> > +	};
> > +	ret = erofs_map_dev(&sbi, &mdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = dev_read(mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
> > +	if (ret < 0)
> > +		return -EIO;
> > +	return 0;
> > +}
> > +
> >   static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
> >   			       erofs_off_t size, erofs_off_t offset)
> >   {
> >   	struct erofs_map_blocks map = {
> >   		.index = UINT_MAX,
> >   	};
> > -	struct erofs_map_dev mdev;
> >   	int ret;
> >   	erofs_off_t ptr = offset;
> >   
> >   	while (ptr < offset + size) {
> >   		char *const estart = buffer + ptr - offset;
> > -		erofs_off_t eend;
> > +		erofs_off_t eend, moff = 0;
> >   
> >   		map.m_la = ptr;
> >   		ret = erofs_map_blocks(inode, &map, 0);
> > @@ -179,14 +198,6 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
> >   
> >   		DBG_BUGON(map.m_plen != map.m_llen);
> >   
> > -		mdev = (struct erofs_map_dev) {
> > -			.m_deviceid = map.m_deviceid,
> > -			.m_pa = map.m_pa,
> > -		};
> > -		ret = erofs_map_dev(&sbi, &mdev);
> > -		if (ret)
> > -			return ret;
> > -
> >   		/* trim extent */
> >   		eend = min(offset + size, map.m_la + map.m_llen);
> >   		DBG_BUGON(ptr < map.m_la);
> > @@ -204,19 +215,74 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
> >   		}
> >   
> >   		if (ptr > map.m_la) {
> > -			mdev.m_pa += ptr - map.m_la;
> > +			moff = ptr - map.m_la;
> >   			map.m_la = ptr;
> >   		}
> >   
> > -		ret = dev_read(mdev.m_deviceid, estart, mdev.m_pa,
> > -			       eend - map.m_la);
> > -		if (ret < 0)
> > -			return -EIO;
> > +		ret = erofs_read_raw_data_mapped(&map, estart, moff,
> > +						 eend - map.m_la);
> > +		if (ret)
> > +			return ret;
> >   		ptr = eend;
> >   	}
> >   	return 0;
> >   }
> >   
> > +int z_erofs_read_data_mapped(struct erofs_inode *inode,  
> 
> z_erofs_read_one_data?

Okay. Let me update these in v3.

> 
> Thanks,
> Gao Xiang

