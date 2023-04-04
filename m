Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F6B6D6626
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:56:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW6r5V7rz3cMT
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZf4H/EU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZf4H/EU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZf4H/EU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZf4H/EU;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW6B2zqPz3chx
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFUi+70wiITyeuozy7B4Yd/jMxRAxWPn5c55TeHG694=;
	b=dZf4H/EUUuLQuIZpSNCpRiBrsjHoaz8aMPxSB8ceotyFlbvPXLVlGNVe11+gSBDM8GJoYu
	/nEnLT18uPuNhCibpYDwgy9ZwsNSKPUhOUpGcOLm/QAKNL74TPpA68xeTmu2PGOYt3X1AL
	u6ss983Q79NRFjLAgyb8Ds9WdoeZ0TY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFUi+70wiITyeuozy7B4Yd/jMxRAxWPn5c55TeHG694=;
	b=dZf4H/EUUuLQuIZpSNCpRiBrsjHoaz8aMPxSB8ceotyFlbvPXLVlGNVe11+gSBDM8GJoYu
	/nEnLT18uPuNhCibpYDwgy9ZwsNSKPUhOUpGcOLm/QAKNL74TPpA68xeTmu2PGOYt3X1AL
	u6ss983Q79NRFjLAgyb8Ds9WdoeZ0TY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-sOG-RRNoPDqcQYseMFRHtw-1; Tue, 04 Apr 2023 10:55:42 -0400
X-MC-Unique: sOG-RRNoPDqcQYseMFRHtw-1
Received: by mail-qt1-f199.google.com with SMTP id m7-20020a05622a118700b003e4e203bc30so19945431qtk.7
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFUi+70wiITyeuozy7B4Yd/jMxRAxWPn5c55TeHG694=;
        b=t5qCluIR5ajOh0aodI2Spb58KM0GJvq2Vnj5ZspPxJW5r6z3gGDmocmt7Em6JEdDkC
         WAWYxhEWLbD4TdpYi8YIooX+/U7UeCOm9EXG3hP2hooztOAbeU9qL8P8lMvl10+ysU32
         DnpligExYoul0YLnuD+buoDAelAGaGCJer3amlszMuoF/jKNom1TzUZI0C8PLJPBV1tE
         MaP6ZOKy6DZU+E3Cb1dB6FqzQ1HWF8Qhs9dC0cmiU2opDDUUF7zxW0r0HNiJwoMaWwCJ
         WU977md8FGjdChITjVc7ZbO60ewzF21p8+7wD8h6do3b+mYtWkYEpJlqLTBU2EqS9MHJ
         0oxw==
X-Gm-Message-State: AAQBX9f+LYKFZaW8i7TKj8ImTL6ayyt2k5MuB+em4aLZqWzipLzCp4tQ
	YANwyvlkXycfT/3xC+NVfw3Epm3wSzv4MIVe7lDuDOkfbhHyf080qS708IHCzMg/p3ag8tRCcXn
	gtJ68WnOqFAsP7EZhH1USOWo=
X-Received: by 2002:a05:622a:199f:b0:3e3:913c:1ca8 with SMTP id u31-20020a05622a199f00b003e3913c1ca8mr4130753qtc.22.1680620140366;
        Tue, 04 Apr 2023 07:55:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zzc10/1v2LcCE0zfPnbg3x+8dh54gKx1zJb5SpW17zpBOCvtCa2VKQbBuo0E40V5nvMeZ6aQ==
X-Received: by 2002:a05:622a:199f:b0:3e3:913c:1ca8 with SMTP id u31-20020a05622a199f00b003e3913c1ca8mr4130703qtc.22.1680620139945;
        Tue, 04 Apr 2023 07:55:39 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:39 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 18/23] xfs: don't allow to enable DAX on fs-verity sealsed inode
Date: Tue,  4 Apr 2023 16:53:14 +0200
Message-Id: <20230404145319.2057051-19-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 5398be75a76a..e0d7107a9ba1 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1204,6 +1204,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.38.4

