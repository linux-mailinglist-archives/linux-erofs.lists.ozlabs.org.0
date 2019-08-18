Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808D913BB
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 02:04:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 469y3S02MwzDrcK
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 10:04:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566086676;
	bh=4XFXJRarSQikf9kF0aORRfn3NTkIS5bVoJEmyRUN74k=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OuF/0vRZoyZq9D9COZ2ynGvkw5tcWyvPFLry5JVC+2rQbpoDr/K/eAkUV0MFR+rdC
	 UbLeKaxTWjAhuBuNLcbfoDf7dE+TsBBcfu7oCRKsvLMqClihrTc3YDmFCTKI90cJkp
	 4aVEHrds/uaBAcFUF6ub/AMFWTrQWj9BiT0kCEr+KC1Otw1kyxOJmyBDXEwUACoojJ
	 c0/LyZFuYMSCQ8Y+pQBM5I/fVzbuGN0qMJTy5TP7zvYv8BHGy8vxnw1iNfNHUH0XNF
	 uK8/rOqZiX5i1rfcGMwr3ZDFaeNOiRwYoipQXDP5LtbZHDA7XCg7gcCEXIiNVfHY5f
	 VPt5pv7e1tk2Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.66.147; helo=sonic317-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="iwBc9fLb"; 
 dkim-atps=neutral
Received: from sonic317-21.consmr.mail.gq1.yahoo.com
 (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 469y3H5gRfzDrby
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 10:04:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566086663; bh=GjexilErYddzHprQKMeXPkQTQHS1qRZ0SITxO8/HqxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=iwBc9fLbgv3aKJuDeNhV1Ke47I5/wMOsEKYCb9/gBrknOeKWKkpZA8edhaIrlDy256fbTMTPd4tPEBeMRJPFo8HtNNrG6a87jRh+ttj4hcCmXrvMYKOgW8nQbkHnNSvrDW/m1KHOP+K2fp53oQoun4AzBHHpcIN8FThKDoI6ePEqjOJ6nnv5/xYwjH+vGMdUfBo5mami0sZ79D2aoJ6ABARtbsLvMDuqO1SnH5JIKrvwGpA0P2sKFkZzTcXUL6bnU7YUOQhO0OQbKCifrj7sS6IoROvawPbLbpXLxAqktkpOuVbwafBDxAo2j16ULRq05nffCa6NK3hFHjZfh5+RbQ==
X-YMail-OSG: qlyDC3AVM1m.SJj9p4kXifMl4UEMDi5zZFVnzwve4k6rrg1AQGhDOsItxbykIBg
 IfPzBSSIcwhF4CsPrrHpwbBSVz779UCooQ0t_5mqpCpL2qDqJKIawTxZz_3Kb8P_yPhVJVIgVA2g
 vqxkx77BxNs5dGYwuCc_87NAVwx3n1hOpjd1n9ZCUduYFhzu1mp8YLKyfAV0tEhmELzlR4ecRB6C
 6VInYbVNJ6x3vjXYR9TSiqorvFBX1pmurA4BXcQsBOfRotddhZ0Y6GcIsL_SfswYk.4JCJtbc8aU
 _xlg1r3eN4a8AyA5EnD9l7FowL737GRa0gePCSykZ9p_dzg52QGn.UIK14J11c9ON_R4NhNblA2O
 KuPyPYz3QPkaOEHF4neM69GuzTxdmQPt1oQLJs6Pb7z3coOhIlWmUO2gin7Ifc8ku7QR9mhm0soM
 IbdDL8xyrXK4.kJvHn8aBoclUaA8G04OBHyD4jhxSJp5003uV6qBbiHuvy27lw_5jkzLEQy1_ggz
 J8N6AlcwYoZuqbtbL81g9PF7ZAjPjcjQVrtKukVaNdv_yo.AJFeXgbPQW0fDN.V2QEm7WSXESOl2
 WUS9ub.Jehc.HY8hNR5BOTSUJXmlELcTMErPVMuso1S1W26aS.NEGRCM9IgjSM86FZgw3hSuRmQ.
 rs.dV0i8XUN3naOfnoz7wgeRbgcpabVTKA3OCjWyNBs.CX_9tXjRweVfu.BqNWWpVOjrUkW1IND.
 v2u734OEoJZWNW9HgtQA2VH0VW2WSUa7DIHIctemOpp1d65EkcF5LqD4qGwAGPWbZbTXbjqt.4cF
 4LYBKNvgX._lWg2q1OW80m8CKwAQKjod0A6ZUL_gsigI_TpQeoVsF9RVgM2viUXYic46xTku.W3T
 f6NVrNacE6BEkZQIFy6lsy_YXxB5wGBXMQHBVF909yNiMWhH2_gpOCj465tqSoC_nkAxFDIXOhDO
 WYbMBdYm1LxDRSK8y26hvfX7_1bwbTGIXlCMANAOWExjQLKTOIFixsaniXVCRSMItTa7OqM5Cjbl
 Dx.Roops.FoV039YkLMrg2KTIspSxLNHTZz9qj66QWqiavhl900wU0DDVnvx.5lgWj1u6S4dY_3c
 KoYzhzPAdiarBMxjrl308WNEai2VrDlXKSHw066yRw8yxpEAaMtbyt6F1Z2nqq9bLxIH0lf3ILAC
 HXMrKFe8fSOezb5kwvp42UZ54p5cotj9FLGIuf7a8wCmImseLDhRAdTLe25PFW0oJQnKXdkrKP65
 nQES9QGEWn3JdgQ5M61p.kOwNShzopBm.3Q--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 00:04:23 +0000
Received: by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ad9a5bfd260b834e47c5b315d99fbfcd; 
 Sun, 18 Aug 2019 00:04:21 +0000 (UTC)
Date: Sun, 18 Aug 2019 08:04:12 +0800
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818000408.GA20778@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Darrick <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 07:38:47AM +0800, Gao Xiang wrote:
> Hi Richard,
> 
> On Sun, Aug 18, 2019 at 01:25:58AM +0200, Richard Weinberger wrote:

[]

> > 
> > While digging a little into the code I noticed that you have very few
> > checks of the on-disk data.
> > For example ->u.i_blkaddr. I gave it a try and created a
> > malformed filesystem where u.i_blkaddr is 0xdeadbeef, it causes the kernel
> > to loop forever around erofs_read_raw_page().
> 
> I don't fuzz all the on-disk fields for EROFS, I will do later..
> You can see many in-kernel filesystems are still hardening the related
> stuff. Anyway, I will dig into this field you mentioned recently, but
> I think it can be fixed easily later.

...I take a simple try with the following erofs-utils diff and
a directory containing enwik9 only, with the latest kernel (5.3-rc)
and command line is
mkfs/mkfs.erofs -d9 enwik9.img testdir.

diff --git a/lib/inode.c b/lib/inode.c
index 581f263..2540338 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -388,8 +388,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 			v1.i_u.compressed_blocks =
 				cpu_to_le32(inode->u.i_blocks);
 		else
-			v1.i_u.raw_blkaddr =
-				cpu_to_le32(inode->u.i_blkaddr);
+			v1.i_u.raw_blkaddr = 0xdeadbeef;
 		break;
 	}

I tested the corrupted image with looped device and real blockdevice
by dd, and it seems fine....
[36283.012381] erofs: initializing erofs 1.0
[36283.012510] erofs: successfully to initialize erofs
[36283.012975] erofs: read_super, device -> /dev/loop17
[36283.012976] erofs: options -> (null)
[36283.012983] erofs: root inode @ nid 36
[36283.012995] erofs: mounted on /dev/loop17 with opts: (null).
[36297.354090] attempt to access beyond end of device
[36297.354098] loop17: rw=0, want=29887428984, limit=1953128
[36297.354107] attempt to access beyond end of device
[36297.354109] loop17: rw=0, want=29887428480, limit=1953128
[36301.827234] attempt to access beyond end of device
[36301.827243] loop17: rw=0, want=29887428480, limit=1953128
[36371.426889] erofs: unmounted for /dev/loop17
[36518.156114] erofs: read_super, device -> /dev/nvme0n1p4
[36518.156115] erofs: options -> (null)
[36518.156260] erofs: root inode @ nid 36
[36518.156384] erofs: mounted on /dev/nvme0n1p4 with opts: (null).
[36522.818884] attempt to access beyond end of device
[36522.818889] nvme0n1p4: rw=0, want=29887428984, limit=62781440
[36522.818895] attempt to access beyond end of device
[36522.818896] nvme0n1p4: rw=0, want=29887428480, limit=62781440
[36524.072018] attempt to access beyond end of device
[36524.072028] nvme0n1p4: rw=0, want=29887428480, limit=62781440

Could you give me more hints how to reproduce that? and I will
dig into more maybe it needs more conditions...

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang 
> 
> > 
> > Thanks,
> > //richard
