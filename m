Return-Path: <linux-erofs+bounces-649-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1298B082A5
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 03:54:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjGF14HD5z2yF1;
	Thu, 17 Jul 2025 11:54:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752717253;
	cv=none; b=iCEGstT6itG69W/172GMTPmNbhB9dCAx2xNIKyUCUgMM+23lF+Z4ov0a/Gp+1dOa6ohfA/1I/nt8kiP22S9gt/zSTv6RAPEveUbEUZjk2blQHVYleW3Cm/VJi6UZKHe/cgai2E5+hO0eiejGCT3Zr0vNkWZgL5mDq6KcEOba/RljQeDKGN4hqN5K24CBQDoTdHg68VMhFbIgH6U5h/aaNlo+MwTpg+A2pQtmyG/MWjfEeQOTVaL2Xa3/NRFQVYiVZW9ANk7JzeE4fORrse846BeHZslMjO0Bkjvy9C3FM/A6bxHyClHvW9bZj16doEupOaHjmSjP2XB62UKQDPK5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752717253; c=relaxed/relaxed;
	bh=EIJgRbo2yBEeYOe56FQ8t29uLldSsA6Cw8nKiYtCDc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT8AnUkHGLeggVsHPzYAxo1cc2gN/Nkg+0LOIzS1if/23oQLAUoiYo0xqb/qQUGhNLIuIxRvN5+jutCUk/L1K4xYRzoIT2THCgmLRj1eNP73/iMAR/oI23YLdnSepCzbfGPB4l9Nff6V6zvXldpyS49ibaMezoh+Theja84okC6aTturTBWZ7f04itenJzqGY56gGiLaOXFI1W3AtuOeiEHFRxekQ0spD9DrfSj5PfCEsZiEDOSMTS3z3+OmjfD13acm7T0fKbQEDsiT62WXNllbhityjgx0OZO98yzAyXdJ57ZaYoPBRyP8uBHI9mTrz1lmceazhHabhV6QCMpqUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com; dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=jz6XkYHH; dkim-atps=neutral; spf=pass (client-ip=117.135.210.6; helo=m16.mail.126.com; envelope-from=nzzhao@126.com; receiver=lists.ozlabs.org) smtp.mailfrom=126.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=jz6XkYHH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=126.com (client-ip=117.135.210.6; helo=m16.mail.126.com; envelope-from=nzzhao@126.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2899 seconds by postgrey-1.37 at boromir; Thu, 17 Jul 2025 11:54:10 AEST
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjGDy4Wc3z2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 11:54:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EI
	JgRbo2yBEeYOe56FQ8t29uLldSsA6Cw8nKiYtCDc8=; b=jz6XkYHHjOmUNGKAG8
	7zHJBqjQXWUhQMLTDbg8FNOvmse7PPf0qd3RKFzMwx+JQAzX7qb7lfhMl1oceFhG
	mZ7e/kTlAWcimrvizDTPt+1IpmD3mXC2jrhIei67mlLI9wrFG/fO1X7lbE1DqhuP
	M5O7aAVyT0SiYT1bn6IUAqBD0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL_QZTHhoBW1MAQ--.5971S2;
	Thu, 17 Jul 2025 09:04:39 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: nzzhao.sigma@gmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dwmw2@infradead.org,
	jack@suse.cz,
	jaegeuk@kernel.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netfs@lists.linux.dev,
	nico@fluxnic.net,
	ntfs3@lists.linux.dev,
	pc@manguebit.org,
	phillip@squashfs.org.uk,
	richard@nod.at,
	sfrench@samba.org,
	willy@infradead.org,
	xiang@kernel.org
Subject: Re: [f2fs-dev] Compressed files & the page cache
Date: Thu, 17 Jul 2025 09:04:14 +0800
Message-ID: <20250717010414.1595-1-nzzhao@126.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <CAMLCH1HCPByhWGQjix6040fZuZhjkj19k=4pqmNzPDtGeZ0Q6A@mail.gmail.com>
References: <CAMLCH1HCPByhWGQjix6040fZuZhjkj19k=4pqmNzPDtGeZ0Q6A@mail.gmail.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL_QZTHhoBW1MAQ--.5971S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykZr1DGr4rXrWxurWxJFb_yoW5XFWkpF
	W5KF1rKr4kXr4xAw47Aa12gFyF93s5JF47J34fKFWqy3W5J3sa9r1Dtas0vFWDGr93Xa1q
	vr4q934093s0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpwZcUUUUU=
X-Originating-IP: [34.216.57.139]
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiZBKNz2h4PiLMHQAAsp
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Dear Mr.Matthew and other fs developers:
I'm very sorry.My gmail maybe be blocked for reasons I don't know.I have to change
my email domain.
> So, my proposal is that filesystems tell the page cache that their minimu=
m
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.
Excuse me,but could you please clarify the meaning of "compression block si=
ze"?
If you mean the minimum buffer window size that a filesystem requires
to perform one whole compress write/decompress read io(also we can
call it the granularity),which,in f2fs context we can interpret as the
cluster size.Then that means for compress files,we could not fallback
to 0 order folio in memory pressure case when setting folio's minmium
order to "compression block size"?

If that is the case,then when f2fs' cluster size was configured,the
minium order was determined(and may beyond 64KiB.Depending on how we
set the cluster size).If the cluster size was set to a large number,we
will encounter much more risk when in memory pressure case.

Well,as for the 64Kib minimum granularity,because Android now switchs
page size to 16Kib so for current f2fs compress implementation the
minimum possible granularity indeed just exactly equals 64Kib.But I do
hold a opinion that may not be a very good point for f2fs. Because
just as I know,there are lots of small random write on Android.So
instead of having a minimum granularity in 64Kib,I appreciate future
f2fs's compression's implementation should support smaller cluster
size for compression. As far as I know,storage engineers from vivo is
experimenting a dynamic cluster compression implementation.It can
adjust the cluster size within a file adaptively.(Maybe larger in some
part and smaller in other part)
They didn't publish the code now.But this design maybe more suitable
for cooperating with folios for its vary-order feature.

>  It means we don't attempt to track dirtiness at a sub-folio granularity
>
> (there's no point, we have to write back the entire compressed bock
> at once).
That DO has point for f2fs.Because we cannot control the order of
folio that readahead gave us if we don't set maximum order.A large folio can cross 
multi clusters in f2fs as I have mentioned.
Since f2fs has no buffered head or a concept of subpage as we have discussed previously,
It must rely on iomap_folio_state or a similar per folio struct to distinguish which
cluster range of this folio is dirty.
And it must distinguish a partialy dirted cluster to avoid compress write.
Besides,l do think larger folio can cross multi compressed extent in
btrfs too if I didn't misunderstand.May I ask how do btrfs deal with
the possible write amplification?


