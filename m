Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE297780
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 12:45:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46D47n1t1yzDr63
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 20:45:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CZ6y3LhSzDqdl
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 01:13:12 +1000 (AEST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Aug 2019 08:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
 d="gz'50?scan'50,208,50";a="353603591"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 20 Aug 2019 08:12:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1i05oZ-0004T4-Ls; Tue, 20 Aug 2019 23:12:51 +0800
Date: Tue, 20 Aug 2019 23:12:03 +0800
From: kbuild test robot <lkp@intel.com>
To: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v5] Add flags option to get xattr method paired to
 __vfs_getxattr
Message-ID: <201908202356.Jnt6ivbB%lkp@intel.com>
References: <20190819183305.153583-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4et4ewpskge26opw"
Content-Disposition: inline
In-Reply-To: <20190819183305.153583-1-salyzyn@android.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
X-Mailman-Approved-At: Wed, 21 Aug 2019 20:45:03 +1000
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Hugh Dickins <hughd@google.com>,
 Mike Marshall <hubcap@omnibond.com>, James Morris <jmorris@namei.org>,
 devel@lists.orangefs.org, Eric Van Hensbergen <ericvh@gmail.com>,
 Joel Becker <jlbec@evilplan.org>, Anna Schumaker <anna.schumaker@netapp.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 kbuild-all@01.org, Jan Kara <jack@suse.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Kleikamp <shaggy@kernel.org>,
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, linux-cifs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Eric Sandeen <sandeen@sandeen.net>, kernel-team@android.com,
 selinux@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 reiserfs-devel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-f2fs-devel@lists.sourceforge.net,
 Benjamin Coddington <bcodding@redhat.com>, linux-integrity@vger.kernel.org,
 Martin Brandenburg <martin@omnibond.com>, Chris Mason <clm@fb.com>,
 linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Vyacheslav Dubeyko <slava@dubeyko.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>,
 Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com,
 jfs-discussion@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Jeff Mahoney <jeffm@suse.com>,
 linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Mark Salyzyn <salyzyn@android.com>,
 devel@driverdev.osuosl.org, "J. Bruce Fields" <bfields@redhat.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 linux-security-module@vger.kernel.org, cluster-devel@redhat.com,
 Steve French <sfrench@samba.org>, v9fs-developer@lists.sourceforge.net,
 Bharath Vedartham <linux.bhar@gmail.com>, Jann Horn <jannh@google.com>,
 ecryptfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Dave Chinner <dchinner@redhat.com>, David Sterba <dsterba@suse.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, netdev@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Ernesto =?unknown-8bit?Q?A=2E_Fern=C3=A1ndez?=
 <ernesto.mnd.fernandez@gmail.com>, Phillip Lougher <phillip@squashfs.org.uk>,
 David Woodhouse <dwmw2@infradead.org>, linux-btrfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--4et4ewpskge26opw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc5 next-20190820]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Salyzyn/Add-flags-option-to-get-xattr-method-paired-to-__vfs_getxattr/20190820-220307
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs//kernfs/inode.c: In function 'kernfs_vfs_xattr_set':
>> fs//kernfs/inode.c:322:27: error: 'inode' undeclared (first use in this function)
     struct kernfs_node *kn = inode->i_private;
                              ^~~~~
   fs//kernfs/inode.c:322:27: note: each undeclared identifier is reported only once for each function it appears in

vim +/inode +322 fs//kernfs/inode.c

b230d5aba2d1a7 Ondrej Mosnacek 2019-02-22  318  
1537ad15c9c59c Ondrej Mosnacek 2019-04-03  319  static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
7d823b0879d4e2 Mark Salyzyn    2019-08-19  320  				struct xattr_gs_args *args)
b230d5aba2d1a7 Ondrej Mosnacek 2019-02-22  321  {
b230d5aba2d1a7 Ondrej Mosnacek 2019-02-22 @322  	struct kernfs_node *kn = inode->i_private;
b230d5aba2d1a7 Ondrej Mosnacek 2019-02-22  323  
7d823b0879d4e2 Mark Salyzyn    2019-08-19  324  	return kernfs_xattr_set(kn, xattr_full_name(handler, args->name),
7d823b0879d4e2 Mark Salyzyn    2019-08-19  325  				args->value, args->size, args->flags);
b230d5aba2d1a7 Ondrej Mosnacek 2019-02-22  326  }
b230d5aba2d1a7 Ondrej Mosnacek 2019-02-22  327  

:::::: The code at line 322 was first introduced by commit
:::::: b230d5aba2d1a7b0636408889a75bf9eae6b8bc7 LSM: add new hook for kernfs node initialization

:::::: TO: Ondrej Mosnacek <omosnace@redhat.com>
:::::: CC: Paul Moore <paul@paul-moore.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--4et4ewpskge26opw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICM8KXF0AAy5jb25maWcAnDzbctu4ku/nK1iZqq2kziZxHCeTnC0/QCAoYUQSNEBKsl9Y
isQkqrElryTPJH+/DfAGkA1naqvOGYfdjVuj7wD0279+C8jT+fCwPu826/v7n8G3al8d1+dq
G3zd3Vf/E4QiSEUesJDnb4A43u2ffrx9egg+vHn/5uL1cfMhmFfHfXUf0MP+6+7bE7TdHfb/
+u1f8L/fAPjwCN0c/xN822xe/x68DKsvu/U++P3NFbR+d/Gq/hfQUpFGfFpSWnJVTim9/tmC
4KNcMKm4SK9/v7i6uOhoY5JOO9SF1QUlaRnzdN53AsAZUSVRSTkVuRghlkSmZUJuJ6wsUp7y
nJOY37HQIQy5IpOY/QNiLm/KpZB6AoYPU8PV++BUnZ8e+9VOpJiztBRpqZLMag1dlixdlERO
YR0Jz6/fXX7S7KzxM0ZCJsucqTzYnYL94aw7blvHgpK45cqLFxi4JIXNg0nB47BUJM4t+pBF
pIjzciZUnpKEXb94uT/sq1cdgVoSa87qVi14RkcA/ZfmcQ/PhOKrMrkpWMFw6KgJlUKpMmGJ
kLclyXNCZ4Ds2FEoFvOJzYkORQqQW4RHM7JgwF06qyn0gCSO292C3QtOT19OP0/n6qHfrSlL
meTUbK6aiaWZQ7XfBoevgybDFhSYP2cLluaqHSPfPVTHEzZMzukcRILBEHnPg1SUs7uSiiSB
XbUWD8AMxhAhp8g661Y8jNmgp/5zxqezUjIF4yYgHfaiRnPsdksylmQ5dJWydkE0K97m69Of
wRlaBWvo4XRen0/BerM5PO3Pu/23wRKhQUkoFUWa83RqSaMKYQBBGew54HN7tUNcuXiP7ntO
1FzlJFcoNlPchTfr/QdLMEuVtAgUtnHpbQk4e8LwWbIV7BAmhaomtpurtn0zJXeozkDM639Y
JmPebY2g9gT4vLYWCrUUWvcjEGYegYm56reXp/kcDELEhjTvaw6ozfdq+wSGPfharc9Px+pk
wM2kEWynylMpikzZMwS9plNkdpN43pBblsB8l4rObGsbES5LF9P1TiNVTkgaLnmYz1BpkLnd
FiVphs14iAtUg5dhQpCFNNgIlOaOydFiQrbglI3AIIxD6e8aTAqMYdpKq4yAcvSdFbkqU+tb
W+RUDaynBBCuKDwcoNqhWD7oBnhH55kAwdHGJBeSoT0aHhv3Y9aCKcWtgi0LGdgYSnJ3M4e4
cnGJbymLyS2K0UIFDDcuVno2m5YiA2MIHr2MhNTmFf4kJKUM29wBtYJ/OE7Q8WTG7xQ8fPfR
sndZZK/Ray0GzRJwzlxvnjMasKd3Zq16zED+45Gz7ey9o/V2VGDZFxZH4Hyk1cmEKFhx4QxU
5Gw1+AQZGiy/BtMkW9GZPUIm7L4Un6YkjiwtN/O1Acah2gA1A1vSfxJuxThclIV0/AwJF1yx
ll0WI6CTCZGS26yda5LbxBH5FlbCX2S/OrThlBbJnC+Y482yqB0elUS9uyYIi3BJhXmyMHRt
lrHDTUieVcevh+PDer+pAvZXtQdXRsBCU+3MwLHbJvsftmjXtkhq7pfGfTtiBCFKRnIIbS1R
UjGZOHocFxNM9YEMuC+nrI0+3UaA1UY05gqMDMi0SHAbMyuiCML0jEBHwFsIfMEe4QZOiohD
pjBF4wE3ajfsKpL49emx2uy+7jbB4VHnOqc+AgCsJUaJ5dwh6OLCkc5cgqXWsWQUkylobZFl
QloBnw4ZwdKNERDX0HndeoTrAk5ISCYSTCQwEkyhpYF31+/6DCqV2s2o63f14maH0zl4PB42
1el0OAbnn491FOT4+HZ1808oR5NMURyhzQdurhPYnwSRh241mcXJ1aePYL1B5lIRMlgoOJQm
OPlok8Tv/LhcUbe/xhh9vBqCxcKFJOA3kiIxsWtEEh7fXn/swiYNhB0xs7OzlwZMknAMnN1O
TTw/AFPQLVLIMeJuRsSKp3aI+Mtds6RTL6Lv9OPVhOfuAm0WmPwIFLGJNV+sj5vvkPq/3ZhM
//T2h6Evt9XXGtJlhu/LGKxDXGbTXOfLaiyfsyWDtMNVbwjXAaPTdixUhfyUSg45R3hr8Usn
p5FtuuGvEravS8iUmyRU3ljWHKQH5mc0qRQSwuPrS0scE5KBD8bTKQjxLJdZL7Berrp+36ko
o9oMOmEWMF97MK33mjeN6qJ2BzUyrfkJ6Pf1cb0BcxyE1V+7TWXZH5XDUkCnh0xQypLHFHw2
hGvEYqOeyRCU3w4g+QiyAi1MBjD4U0KUK2rwi6/b/1z8N/zn3QuboMY9nk8vrBkiUM00BR4m
vH7oCJHPUpcH3OhEC4ZO7QWQ2nxFuNcxNq3Ofx+Of47ZqqcBEa8VVdeAkuUziNXsMkiLycEt
YnAVcwQaEjZI61vMglGf7+pIQiwubbEJJSrHes4owcJva6Iys80MxiGntqXNw+5cbbTReb2t
HqEdBBBjJ0klUbPhdnX1mEZ1SnDLuRPbeuBN/c6oMnjz3PCrLUzYvS+4lnGn5qDNkWUpRFiA
sdJRlwl3dcQ2sJVGgwcGEmxCUw5x8n5tNmEUEyGP4rMpFYvXX9anahv8WQdeYL+/7u7rIkkf
fzxD1ulpXEx5auSd0usX3/797xfOsnX1tKaxzbADbKZEg8f7p2+7vePme8oS4lcd8cH/pcjw
7Mqi1vGZymVBcRPnDDeMt34hSe0qYD8TnUvYDsbE2irR+c/FYGOdmoMB6YSN6hIHCRFNaGiK
VOO9jWs0HtaIsKm34tl104+StCvLehKBlpJPn0Nr/YDcGx8slzyByYJwh+VcpyVoxQViTidB
abLlicIHtvC+CmyfcOdsKnn+fFp+B3qLM7OlyGeg5Pk4ZLfIaBICXsf/UjHcdmqy5ST3d1FX
WrgwQk/9k9bsFBkZq3i2Pp53Wl6DHAIyR6dgXjnPzX6HC11WQKVPhUL1pFbWG3EH3GnPcMS6
lC36apxlg5MbWFtdiwkZMeyyDGGPnN9OjLHty4kNYhLdoHrtjtcl36nZEJWBYdAKA1EXt+Ox
Bi9hKg3+ORzadgmyxXyNbaTbui/KGXaxH9Xm6bz+cl+Z46/AJMNni3ETnkZJrv2DUxtxvZn+
KsMiybpDFO1PmjqsZavqvuq4dgROOGQpD3aXukd7w32TNStJqofD8WeQrPfrb9UD6ogh8cyd
lFQDSpNWARgiZ/t4J4vB/WW54aDJGa+siplO+amWR0SQs9mtAkEPZZl3CUdfQlFY3tdyTQfi
OuUyza+vLj53WVzKQAYhRjcOfZ44hciYgU7p1A9V2kiKNNdHV3jtzy3gdvC7TAjcNN9NCtxg
3RkvJPBkWJ/I1PUJncjPfdZslsA2cCl91QsmTV7oPeiYgg2bgP2aJUTOUX31i4lV6m21own/
IPwYCxMIwJw5e1tDypATrFhdpNwqFeovUARnIw1s2Lr3ZzG+5FUEKUnhs/s6sp2zW2Q+PHVn
z7O6wqrDZ3wLs858l+Ascs+IQJaluLDpyfCMP4ecakPCkmKFF7puIZUSYs4Zzou6j0XOvdhI
FPisNZLg5yUGxxQ+bV6PqS2Ch8lmS20LrbMlmrVgt6cizPwiYCgkWf6CQmOBiRCMCtyP69Hh
n9Pn3HFHQ4sJt6pHralq8dcvNk9fdpsXbu9J+MEXu8H+fPRtj75BoBOfsfYOaMDGmtQELEGS
+YwJENfJEx7MZM8gQYhDSj07rg/OchwnPedlOUgIfl6f4yXd+NIzwkTycIrlvyb5MduviC1W
DQjtbBGTtPx0cfnuBkWHjEJrfH4xxUubJCcxvneryw94VyTDI+lsJnzDc8aYnveHK6+m+w83
Q+qJ3GEziIlRUbTIWLpQS55T3EwslL7z4HFMMCNd6PNrbpJ57Ht98ogPOVN+q1/PFDIIL0X8
HkIeBSpQPkeV0uHlgTZ0qFMGU1qREAb/gobGRCmOmRpj1VblpFC3pXsmNrmJB644OFenc1s1
sNpn83zKUncOjccftRwgbO9usZYkkoS+ZZEUlyBcWkkE65M+CxCVc4oFhUsuGWTx7qFzNNVi
/26UfXWIfVVtT8H5EHypYJ06Vt7qODlICDUEVkrUQHQ4pUtKM4Cs6uPci37EJQcobuuiOfek
73pHPnsCTsIjHMGyWelLqtMIZ16mwP7HeOBrHHOE4+JlXqQpw2cfER6LhesZDJPrKmAQHnd/
1cllXw7cbRpwILpAsQ/s6qPDGYvxKjuoX55kdlm/hZSJrqk5R2FpSGKn2JfJuvuIy2RJIH4y
t9tavYl2x4e/18cquD+st9XRSoaWpg5klxbZCoLzrh99Na7nSUtdX58YLwWhxMszjfIN59WV
GCGFWJrCh5MBdnyZFPBfyRee0RsCtpCeELEm0DcJm24g0U5gt3G3rckIRJ20Jc6kmGDe1zq5
a+63OBfLPDJidmjydAq2XQW+a2KD7cwTxNZbIZ+mnmJYkuOuUETIWprKE1YXM0cpkxg7sGpJ
ikmItQSwDt+xO3stCYWN7+77DXCxEFlfHLChJl82pefrT+NhqbzNcqHpni2yhXKCeaZu2ZPQ
HKsMwJLgwRvEQKU2IPq45NlhB6PWjm6RsEA9PT4ejmdbHhx4XfHYnTaO5LQiXiTJra76oGND
dhwLVYCdAEU2goqb48vhaV1dL2KgAUlwsubX9msw5ef3dPUR1fhB0/pSaPVjfQr4/nQ+Pj2Y
2xen72AUtsH5uN6fNF1wv9tXwRaWunvU/7RZ8v9obZqT+3N1XAdRNiXB19YObQ9/77UtCh4O
upgXvDxW//u0O1YwwCV91Rp7vj9X90HCafBfwbG6N/fGe2YMSLQK1xrf4hQF7zcGL0A8HWgf
VIKAQ2A02od+EHMa7nbXI+n6uMWm4KU/9Ofq6gyrswslL6lQyauh+9Nzt+bdlkWf4ZMlM3Qm
UFlxRLuZNoShNcRieOsWAakPBZwDKcJDfXda4vKtRmFte5cTGcgypLgdzYmc6hh3cAuwj0R6
n2BFJ00RtTcLIg0Hyayt0rYJYjeFuYLvj/9z5rFOEPfpvM+XnPtQi5UPo32fx4FOPVkszAHS
fN/caX2cj1UlitTmAnyWC8NJc2HeEwgufGY4jRO3gltrno5QewuydcU93IG12X150gKt/t6d
N98DYp3eWeSdRP3TJl0Ypg/ZneP3+mA8DYWE+IhQXdw3LwIQdELubP9po0Bk0pwTHCkpDi+k
kHgTSha8SHAUuA6e4s3YHZ3ZVwIs1FSIqXNxv0fNCrJkHEXxT5cfVisc5V5MsjAJkQsWe3Ac
xMk7SYNVLMEnk5Lcj2O5FKlI8BWmeKNP7z9foAhtAHS05Ni8ZFAwGTeToKyKKLRLqQsYEkVB
nqUK+zKpjRMxkVFMJL4wJSiHhGWFyzPEhCJTt/iEFtwpZSWQjzfRtadgdDtIIFtEltlmAz71
w4phzdbBh0wfDnnGydprGV50kmX+tqbOPrz3ZVMIf1syDKIdrElV8hyr95uLOP01onhGbZZo
bJeweepmhkaB5uBVDoNO9GGa/tfHkV3Vgcrr025bBYWatK7VUFXVtqlSaExbryHb9aO+tjTy
9svYvn+lvzprFSY5m3twufOGCj697wrcZoltQmzUREKeCzzDsZQrKnDUwCwNUVLx2J6qudqF
nS7YDUcGzUGykBMvZyRxnw46OEZif0PFcYTKcXjuob+7DW2TZKOM02KpcSZ1BmKKWsFyp+tS
L8c1vFe6+HWqquD8vaWyfXI7hCeWMWdESP2nRS8cewufZTZIh+tRukt32+HdOtBO9xjw8yd9
99BafsymhN56gU2y+966wJmWU4UHe821aZ+tMfk8bi/iEATYPFxprgN1BZRFfYZulVQWcwDh
RoFJTuL6zkyBR+KzJXK3veVPEjdIN7RfojWg9lXbiPl1lnNJsbxVg7FebHKL+j1ufFWW4FXy
mad6nmXjpC6DaHlzf9j8ic0TkOW7D58+1W8rx4l5rRaNC9TXob1nZZZ+rLdbc4NmfV8PfHpj
B67j+VjT4SnNJV5AnWZc+Cq5mVgysKoLz/srgwUf5Dn3qfH6KnHsOdqE0Dkh+LSWRB+ICPz8
RbJpEQ+fTdT13eP68ftuc3I2pa3rDXGdf3Wu6eoaLY0Jt1wFeLpSzCgvY57nMSvB2nHi3ohd
4hwEVVP6PanHfi3BVHhOIQnV70j5BGIPV+XrzCYhkyKyLjr0wq2jCgh4GKoog3bWcMUKbEjm
e5lWeA5XzL3VWr2xO3saDWFgwtKidQnJbnM8nA5fz8Hs52N1fL0Ivj1VpzO2Yb8itRadk6n3
mspS3+xC9ZAafVGHp+MGTQZRvJ0Y83giVsi6OcT6hfUAxjl7MMggW3+r6utRSP3wV6T1Q9/q
4XCudA0ImzuCrVs9Ppy+oQ0chMVbrR36fGvEPkgWgpfKPP4NxB5M+e7xVdA9DRiUnsjD/eEb
gNWBYqNj6LoddKhzcU+zMbau0x8P6+3m8OBrh+Lrku4qexsdq+q0WQPDbw5HfuPr5Fekhnb3
Jln5Ohjhat+3yq5+/Bi1aUULsKtVeZNMPbchanw6TGlaTznu3PR+87S+B354GYbibSGBVIaP
JGSlr4OPl9L0iWG7yt4/ki3L2SQ6bokk8xTSV7pQ5TPRQuJWj3usXrZMRkvVJfwNzBIzZCOc
7cqUKS7qe+txjJxjQkTgPOd3Knn6FEsTYDvtNhy4Zeq5YijJONIh++3xsNvaY0OUJwUP0XFb
civm9BxK61OSMSNnS13Q2+gsAYms1PAOTvvObNyqb2QOD9BIkAvP5bWYJ74Y2KR9tD7bw49j
6menuAN2j6WbY18wH/U+Oaq+gFwv1M8kI4VcF2/XprS3Ic7JK0j7JSB8mvB+gOsxV6V9sG0A
+sGJfjqu+xyMcWUmZp5rE4qHcS2VYrTw3q83RL78/o9J6Iyrv73E+hB+Yq7X9quQjOuXyqpe
mqV4Ddj8NoAnzGxI9M9WwLZHuDWwBihX+hADpfrDEKColR81jZR3Jye59DdMefxM0+jS31L/
hgHBghq20tGMy8UWVr/OKEWGCZaORs2LYeeFe6JvR+T6R3MGeHsmLDWHwvjl7UilIueRlaKH
QwCvAWXzUwR916RGIL3eFCJ3KpkG0F0KM9ofEfTnFsyPFDT0+meYBuupESPZ7fH6Zv3i3TO4
S998nd9x0HWASBldfnBhNajnglFuXAx0UQWygQG6Nk/rzXf3FDtSyJ32NoiuqWvy8LUUydtw
ERqj19u8druU+Pzx44Uz8z8gPXVvP98BmWfWRRiNFtTOAx+7TqeEehuR/G2aD+bVRwnmxYtn
1AW09Spijqha6wzwYWu/f6qetgfzdmLEJmOPIufXMQAwd995GNjo96000FztT0TKQfucO/Ea
SWc8DiXD9E0/TLZHNb/o0X+216L6/N7cinreQdQ0I7PZx2ZRWFLJwAs6V+vMHz9jEeZ1XepK
mbY4MPucub+ZISRJp8xvGkn4DC7y42bPorK48KInz8xm4kc904pKknhQ6qYgauaT8We8lP7h
gZXXkCTPrD7z427S1dWz2I9+rHxu0OyZHwC6VQtfs/+r7Np628aV8Pv5FUafzgJtESdpLg99
oGTaViNLDiXFSV4M19FJhDZ2YDvYZn/94QxJXTmUF9hFdjWfKXJ4H818k3VKLM04ynZHDKrI
sUmPE4LlB/wrqQ4MKEE8YvTopCpf55aR/1Nym3wq9turq2/XX4Y1z0IAyNdwXEHOzy7traqD
Lo8CXdq9zRugq28nx4Dsnu4t0FGvO6LiVxfH1OnCvqW3QMdU/MJOKNcCEX72TdAxKrgggj+a
oOt+0PXZESVdH9PB12dH6On6/Ig6XV3SepIHDBj7SzuLTKOY4ekx1ZYoehCwxA+IKKhaXejf
GwStGYOgh49B9OuEHjgGQfe1QdBTyyDoDiz10d+YYX9rhnRzbuLgakn4bBmxPUANxDPmwzZE
fbrUCJ9DFF8PRN44MmG/e5YgEbM06HvZgwjCsOd1E8Z7IYJz4ouGRgSyXfJ658ZEWWC3nzTU
19eoNBM3ARFyA5gsHdtncRYFMD2t58eGRUbZuvP1+644fNg+udzwB+JApa0ey9GMJ2jrS0VA
GI2cFhIjtG7hGEw2ZWLEIz7Cm64fzx8qbrGGe0IbZn+dYjsCDPiIOGIhVHxh1U5W80wLk9n3
Tx+r19VncNV9Kzaf96v/5fLnxdPnYnPIn0GfnxqccC+r3VO+aYbw1gPGi01xKFa/i38Mj3N5
zQ9STZikyVUqC0rF+qEYP0LObugYXDvcexDcHgnjwJOEGVhbRaghL1xGiYR52oCBC4DENuOl
21pq0ehZlFxa3duj3ChYueabL1n+7uPtsB2st7t8sN0NXvLfb/VoFQWWzZuwOr9i4/Fp5zlE
NVkfNsx/+rlcGOS2au9CDSG7WMujjOgeLcc/xPFctyRLp5xw8NKQNgu2utq///xdrL/8yj8G
a9TkM3yZ/qgvKfrngogF1eKRfdnTUu73yUUr1lSZ+98PL/kGGNfBB5ZvsIpA3PF3cXgZsP1+
uy5QNFodVpY6+77du0SLJ26xP2Xyn9OTeRw+DM9O7Luz0T+fBMnw1L68tzDOrkbQ6Tf7ucWM
uFhkycW5/axXx8iXOUEJvw3sEZxlv0yZnPV3nZ7x8HP06/apaXwzmvOcI9Ef2z0UjJgwW5di
ypqgq+wsPBQLlzh2V23e07J7d93k7rwQFKOG7n9w50gzy7eo1f6FVrg8frhKnfbI73vaddf6
vXZpf873h85a6wv/7NS3LJQocNbiHtZY90Lop8OTERUKqqd1XynHTOjZyH5gL8XuXwdy4vAQ
/rpgYjbqWTMAQVzsK0TPciERZ6fudWDK7Fe6St7zDon4NnR2rkTYb0lGPnOLU3no8AgnLLPD
TcTw2lmJxbxVSzWXireXlmtDuRo75zPDbAB9CEUX6kRFmRe43yR8ZwleGC/G1N3DTB424/LO
5dzGgcXFObIB4BwJI7fKxvjXuUhO2SNBFGfGAgsT5h7RZu92734Ui72Ri7m88LoHrbNXUu5U
drqI+/pMQyxjSI3W7evbLt/v1Q2k2xV0LILZDh8JpgIlvjp3Tqfw0dl8KZ4617/HJO0GsorV
5mn7OojeX3/mO011eLA3kEVJsPTngnC3M2oQ3gT9/lygH0GacuHibKyd5Zfy1rDs22VKYHLj
B/Np/w0BwT1tKXGMW7kYzX6/KO9H+e4AfkrymLzHUIl98bxBvuPB+iVf/2oxaR4DR3xY/Nyt
5AVvt30/FJs2b1+HqUtLvCAF1gGR1D4OGuchpDFKg9DCgjwOohHwCyTpssWL5seildClpjFf
XgBkt1rV5GOKgAbYebLwl0GaLYmyzlr3QvlArh7hmEg8pAFh4HPv4cryUyWh5hZCmFjQUxsQ
HmHRklJyMyL3GN9uJQ0DT532qJ/ZzzbKM5/QUYm6fwQiIYv6FN32jJFkeSiTc4RyzRnd1gP4
Qvjg2yDUErfIJ2P7ZTCTba59dpZvbjk8gV0tmhBN07OsM3mahiczK/Hp267YHH6hZ/7Ta75/
tln9dB4a8Na3qlLLIX+C1Xjmq8BZyGGjCMnNl7dLEnGbgSfEefV1PEng40KnhPOqFl4cp6Yq
o27iEa0bsr3lhlf8zr9g4iFckfYIXev8aTbtKOqOts+UFvIIiclnWZIq96uqc8dCHpjQeeb7
8OT0vNnFc0yR1uaHrYa4XJ6xYEYE2GiGWVmAFxMMTqre1Kdsk0sFmTsph3NVRMKRcxL8DWas
RUNlmtSCqNRtcRQ+tPWBqWuaHky6okjzuwCboyactPbv0T1YOWeVxPQVTSj22veTP0MbSgUP
1UOPoH6Ky779FNlDPxqW3VH+8/35uUUWhZ/O+H3KoyQgzKOqQADSfJZYTLyIqBBQEEsNJ3FP
l8beD04ZQnSnh8wW0ooWeq2QGZ+BibjblUbiKh4t3BlMegfqzs5aiopXWerAplwztSqS8huW
sMjs/pVUPcY3fx/+p21qrrqtsVFgeX49P4VhQmeRfKwj3eYNgwXgXW2ftkhSlDkE3j8It+tf
729qSE9Xm+dmQEw8RmJYzE2V0nw8SricZpHK0GYFLW6JyKTSvdden/poi+SckbM+tjtLNuTg
ApzxiixcCWHLibO0emy4klVSpKrl8JjmX1W/UmOKy7Me7QireZjka284b1M4qpMpWCbLwTD4
7/6t2GCM2ufB6/sh/5PL/8gP669fv/5V2a7QZRTLnuDuXYbL1PbQ+K50DbWfhqAMaKOj4hUV
u2t8WYKEWpD+QhYLBZILQbyYM4LKQtdqkXBiI1MAbBq9qlUgUB7eefTxx14oFicHfwp0QuQB
sGqB8yz1L7q7HKRlZqB6D+OWJxsp92YwDQBdLZ07SS+Uah12r7PyX3nl8eL6pcciaWszINSi
t5keOUFEr4TocBxwguJGYXwhVQC8H83Tibqi+5l9l4QsjpAGju5UQPT2PIIEI+gaMFXkbWLz
Xq4lg6xtB+2ZcavPKsJySmn2Dw5UuesjsZ4VaFS55MA+LbezH7xD8F2C1eHFjdFE+mlsi9wH
pTTXJ1NyZzTrXBtwmVEJVa1vk2K5KY2Vtu2bkVqbHYDpAujQHQB9xi4pgBFJZV8A2TKJ2BzS
utpMCHJSym1dJSTjnW/s5jmLZM9g6kP1A2KtLOHAT+cClukZYsfIRInK7UiwiXc7B29CVIpi
AflXZmqmQL/r6NXqhUA0iGnekk6OpDqElHpVijSg3qdnpAf2d4cceOblDTGeyeMCicKbgzxH
LN2Fabp2Ug5Z0AL/4txtP8CGT/k9cEE6NKOu68qvhBiTGpf4hGUQATcSkRIhXAjAm6/dvIRy
ZUpwyuVCExJEYoDIsnYcXF16z4QgQqpRDlEWY3lWoBECTJ6YyMuhcMoqitJgZDeIq3F8Q3BR
gPDOkSRANT5B6lBXF3lzl/pDORWmMa5T9sM/WiEhuZF7bmNphgzVMaAwHMLRHouJpDkg0TGK
dPhSg3IWO0YEJBSWK7dzdqAplzAlmkJIgJSR0xNvsdFyBKSXfixE1gmtqnYgJOslXOG9hNkC
RPC5XNaDSSQXzdpOyZkIH6ocrl2PJGV9+z/bV54U8X8AAA==

--4et4ewpskge26opw--
