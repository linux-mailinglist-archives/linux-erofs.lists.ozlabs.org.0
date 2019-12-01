Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC210DFF3
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Dec 2019 01:45:10 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47QTzl0hKlzDqgF
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Dec 2019 11:45:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1575161107;
	bh=r3iq584qFQZ6k/5MFhliU4Wp6HHOZMEVxEy+gWH70ns=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WXrb5jkSk0ghAt7d4kWWQxsPwXFF7X/mh8gIZtEdo8VSGkOWvMtTI7fP1zvCYZDiB
	 uWipkmfInSMG0DseWGJpa9/T3yuZFX7E8ihLvcHA4FDSfMZrAsbKriRM8CZdLuOI8V
	 fmX02rrl43wiUkPZqWsLZMVmF97gm2wBzyLH6KZlskdW1IV4ObBzO1evXDL+je/CJF
	 WF8H3SPcdjGV9DwC65HjeAtiAbwn6QWMzuEFtzQD+ZkzAE7HK7+9tnM6mZTZSNqWAz
	 vpZA3G2Rku6dzD3wj9GcuCnCG7Ur0p/7RRb5fDux2bXOw2uJeAeTWjGgsJcyjd+YQs
	 RXE+iON1SwgYg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.206; helo=sonic311-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="eHjM8l0T"; 
 dkim-atps=neutral
Received: from sonic311-25.consmr.mail.gq1.yahoo.com
 (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47QTzV0c0nzDqF3
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Dec 2019 11:44:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1575161088; bh=akQyBLvV4lmWYbR3Aefz6lC6etSGyAUm1RtgE6qHjuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=eHjM8l0TkwcBAJyT1OQQl1ESL+U8CC03Drg9H4PZH2DV+7Pfu/vPBkC3c2heB42hORl3Wv90Xqu+8ghNwZWc/kUclALyew8eAN/f2Iizccj/hzDTfirsn/RJJZGNbrHEzEzB5Cg7sBpMZVYuLS6O/nQTqOzDtdigWiqr9ZvdVz+Vrv8gXE51F+qdopWZhVvyaxxvgRR0w81oTOLNQtJJ70H03CojqTJaU5OFV0oVb379xoWO+7MvW+aC8xnUmC/eUKd5pQ3Gz+lA2vcQMvUFuPkTBglCfbrOB7gfnBItlS2o85YQ3E3yiBmSClHQklzsWBgBL9mozM788roBhtdDEw==
X-YMail-OSG: ULWE.moVM1nPQMz_ZW8lg5PSfOpvFVQ3c8XhWQV_3ePv7b_Cmd8XpsJG41NId0F
 YgvIWnTyFgBNt5IzEctWFPKzR0lGXdaA9nuRb4etZYkG7SR6O402QCLEb6zn.0vtAq0snuPr8xuy
 BXpabm9agr6ch37SzWaxi0c6MDt6XASaH5PSybNmXSmLzflCvW3Poq7le.BogpZaPQFPTWiXBDMM
 C9Lygp5D8WdEPDzmmHqYTa50CJNR.fcrfTov6Pudo4SiW.q95Si52qUF9fwiqRhVbllU9zCxPHzf
 3NRNRWJ2cZFFQaqLudD1AJsFyEMkbC9RP05bRKhHf956bQZ5nsVuaE7HnLEpWtDjHaFv6DhqZTVW
 hyXaZOjKGRIjRYlu0Vod7eAQNan.IyFm.dlRm_sphC8lE45Pn320Wp_FhoVgnJ2RCs3WZH4qoMKf
 jWwUBrgzXLwImsWZhzrwwBi3n.v.8XBY0wMJx76_OBu_9SbdAQDpJ8k2T9X110DqBsweDA8ANtpg
 _JHvA7y.n134rgbbVAGkEkItcbmNqmRNkdKntDnh31UxMvD6ImQ0IIQbAatABlpmAqeE2Pxe7CiL
 OO.quf.hQCHo3vq9ufzugG5N_jfy4fhow3SkNBM8yS4ppv_IfG2CKx48dDlsKyXOE6Ww9lg_1WoC
 TQFu.NM_p21JsHjADl9zN_9ilfhAUFG8DQekYNE8Df73FRQLRMQBkV5nfACYyh7eIwad5AYMaJ7T
 YS_lJC0wAYMg8YIgdfogs63G9h6YZWCdji.3ALj17C4TMQzgLHAM7dPAq1zUHTEZ2vogDhedbomK
 IOQpekGr7dKWrcCF7TkSwT1fS7Ie_5VKErGMnHzRi6Lltd1QrzSZBMN4.lXJy59M0p.ie7YErsUo
 3u9RAh5BD9gjAQmy2HDqRwaxZW5tZDrZS8LTcFhiD4zkfeonEu7M42jipaquk8YlXsKjRRl_W1Tc
 SB52aKkDd_v9Qt3NezlD.MEFCYSPYNofiNNM33YpYPF0bdS37VzXP7llrEJedFnKrOt3tIY91TGJ
 uu7Kzb765WDj467q3q2LiT5HBBIumEuZuqLI_wAJ2ypjlgvGf_iLYgr6qtxyHn0lkC4GRi6aQ6At
 ArD9XbmR9sLu3mno.UldBXPNRKMipvIyDchPRgkUWaVEGobvahKBnjGu3Zb8cTjOmt.zyMQwZBNt
 O8bjFSIW_SQ1vlkCChTj48nIGOdCnpj5MJexoGcBzA1GyUmiGqF5MhF9ZkVhX6seg_wnl0bpB69o
 VI_CY4SWpgjb5XlzhfeQ611tHMmy.xi97IgaSGdrk5JFb3KoT0jRukmxq5li5Pc2dNnaMGcoGW76
 5qV0e.SndFDWVqIS6GD2kXGqXUn9_a.yTrRGhzp2tojQuJ4QvVQ4ef_dPYy.fwz68qzjq_uzJRb8
 oGvZfdw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Dec 2019 00:44:48 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 03b1dfd2ad948a63a4321596415fc5df; 
 Sun, 01 Dec 2019 00:44:44 +0000 (UTC)
Date: Sun, 1 Dec 2019 08:44:35 +0800
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: Enhancement request: exclude paths from mkfs.erofs
Message-ID: <20191201004431.GA24276@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAEvUa7=N7qUobof=vwpXF2XfXcW8R67SB3KV1phRN2ZmG23CvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvUa7=N7qUobof=vwpXF2XfXcW8R67SB3KV1phRN2ZmG23CvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Sat, Nov 30, 2019 at 02:42:37PM -0500, David Michael wrote:
> Hi,
> 
> I'd like to request support for excluding paths in mkfs.erofs similar
> to the -ef (exclude file) option for mksquashfs.  An option that takes
> a file containing a list of paths and glob patterns should be
> sufficient.
> 
> For a simple use case:  I want to build an EROFS image from a Gentoo
> install root, but I don't need development files in it.  An exclude
> option would allow generating a smaller image without the unused files
> while keeping them in the writable source path so additional packages
> could be installed on it later.  This would have /usr/include and
> /usr/lib/*.a for some basic entries in its exclude file.
> 
> If this isn't something that anyone else is interested in implementing
> in the near future, I can try it myself and send a patch after I have
> some time to get more familiar with the code.

That is a useful feature, and I was also thinking that "-pf PSEUDO_FILE"
is useful since root is still needed for device files now...

I have to admit that squashfs has many exist users (thus many exist
developers), but I think in the long term EROFS should perform much better
due to our overall project positioning, ondisk format / runtime advantages
and active community due to paid job maintainers on this as well and open
mind to all new useful features.

For me, now I am busying in XZ algorithm (although there are other random
intra-company exams recently killing much of my time). I have to implement
it to prepare wider scenarios. This is the first priority thing of EROFS.

Cc Guifu. I'm not sure currently he has some extra time working on this.
If some chance, we are very happy that more experienced experts could
join us as well to build a real powerful ROFS solution together.

Files can be simply filtered in the function erofs_mkfs_build_tree.
Any improvements (no matter big or small) are greatly welcomed. :-)

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
